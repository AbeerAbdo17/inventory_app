@echo off
cd /d C:\xampp
start "" apache_start.bat
start "" mysql_start.bat

timeout /t 3

cd /d C:\Users\afrotech\COC\server
start "" /min cmd /c "node index.js"

timeout /t 2

cd /d C:\Users\afrotech\COC\client
start "" /min cmd /c "npm start"
