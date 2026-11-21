# Перевірка CRUD для книгарні (заняття 1.2).
# Запуск: спершу застосунок має бути запущений (.\mvnw.cmd spring-boot:run),
# потім в іншому вікні PowerShell:  .\scripts\test-crud.ps1

$ErrorActionPreference = "Stop"
$base = "http://localhost:8080/api/books"
$script:passed = 0
$script:failed = 0

# Виконує запит і повертає код статусу та тіло (без винятків на 4xx/5xx).
function Invoke-Api {
    param([string]$Method, [string]$Url, $Body = $null)
    $params = @{ Uri = $Url; Method = $Method; UseBasicParsing = $true; ErrorAction = "SilentlyContinue" }
    if ($null -ne $Body) {
        $json = $Body | ConvertTo-Json -Depth 5
        $params.Body = [Text.Encoding]::UTF8.GetBytes($json)
        $params.ContentType = "application/json; charset=utf-8"
    }
    try {
        $resp = Invoke-WebRequest @params
        $content = $resp.Content
        $status = [int]$resp.StatusCode
    } catch {
        $status = [int]$_.Exception.Response.StatusCode
        $content = ""
    }
    $data = $null
    if ($content) { $data = $content | ConvertFrom-Json }
    return [pscustomobject]@{ Status = $status; Data = $data }
}

function Check {
    param([string]$Name, [bool]$Condition)
    if ($Condition) {
        $script:passed++
        Write-Host "  [OK]   $Name" -ForegroundColor Green
    } else {
        $script:failed++
        Write-Host "  [FAIL] $Name" -ForegroundColor Red
    }
}

Write-Host "`n1. Перелік книг" -ForegroundColor Cyan
$list = Invoke-Api GET $base
Check "GET /api/books -> 200" ($list.Status -eq 200)
Check "У переліку 5 стартових книг" (@($list.Data).Count -eq 5)

Write-Host "`n2. Фільтр за жанром" -ForegroundColor Cyan
$poetry = Invoke-Api GET "$base?genre=Поезія"
Check "genre=Поезія -> 200" ($poetry.Status -eq 200)
Check "genre=Поезія містить лише Кобзар" (@($poetry.Data).Count -eq 1 -and $poetry.Data[0].title -eq "Кобзар")
$none = Invoke-Api GET "$base?genre=НеІснує"
Check "Неіснуючий жанр -> порожній список" (@($none.Data).Count -eq 0)

Write-Host "`n3. Одна книга" -ForegroundColor Cyan
$one = Invoke-Api GET "$base/1"
Check "GET /api/books/1 -> 200" ($one.Status -eq 200)
Check "У відповіді є поле genre" ($null -ne $one.Data.genre)

Write-Host "`n4. Створення (POST)" -ForegroundColor Cyan
$newBook = @{
    title = "Тестова книга"; author = "Тест Тестович"; price = 199.00; year = 2024
    genre = "Проза"; coverUrl = "/covers/x.jpg"; description = "Опис тесту"
}
$created = Invoke-Api POST $base $newBook
Check "POST -> 201" ($created.Status -eq 201)
Check "Відповідь містить новий id" ($null -ne $created.Data.id)
$newId = $created.Data.id
$fetched = Invoke-Api GET "$base/$newId"
Check "Створена книга доступна за GET" ($fetched.Status -eq 200 -and $fetched.Data.title -eq "Тестова книга")

Write-Host "`n5. Оновлення (PUT)" -ForegroundColor Cyan
$updated = Invoke-Api PUT "$base/$newId" @{
    title = "Оновлена книга"; author = "Тест Тестович"; price = 250.00; year = 2025
    genre = "Роман"; coverUrl = "/covers/x.jpg"; description = "Оновлений опис"
}
Check "PUT існуючого id -> 200" ($updated.Status -eq 200)
Check "Назва оновлена" ($updated.Data.title -eq "Оновлена книга")
$updatedMissing = Invoke-Api PUT "$base/999" $newBook
Check "PUT неіснуючого id -> 404" ($updatedMissing.Status -eq 404)

Write-Host "`n6. Видалення (DELETE)" -ForegroundColor Cyan
$deleted = Invoke-Api DELETE "$base/$newId"
Check "DELETE існуючого id -> 204" ($deleted.Status -eq 204)
$gone = Invoke-Api GET "$base/$newId"
Check "Після видалення GET -> 404" ($gone.Status -eq 404)
$deletedAgain = Invoke-Api DELETE "$base/$newId"
Check "Повторний DELETE -> 404" ($deletedAgain.Status -eq 404)
$deleteMissing = Invoke-Api DELETE "$base/999"
Check "DELETE неіснуючого id -> 404" ($deleteMissing.Status -eq 404)

Write-Host "`n7. Неіснуюча книга" -ForegroundColor Cyan
$missing = Invoke-Api GET "$base/999"
Check "GET /api/books/999 -> 404" ($missing.Status -eq 404)

Write-Host "`nРезультат: пройдено $script:passed, провалено $script:failed" -ForegroundColor Yellow
if ($script:failed -gt 0) { exit 1 }
