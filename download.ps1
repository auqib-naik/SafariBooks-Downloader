if (Test-Path username.txt)
{
    $username = (Get-Content username.txt)
}
else
{
    Set-Content username.txt ($username = Read-Host "Enter username")
}
$password = Read-Host "Enter password for $username" -AsSecureString
$password = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto($password)

while (-not ((Read-Host "Paste book ID or URL") -match '(?:/view/(?<BookName>[^/]+)/)?(?<BookID>\d+)(/|$)')) {}

$bookid = $Matches.BookID;
$bookname = $Matches.BookName;

if ($bookname -eq $null)
{
    $bookname = Read-Host "Enter book name";
}

safaribooks-downloader.cmd -b $bookid -u $username -p $password -o "$bookname.epub"