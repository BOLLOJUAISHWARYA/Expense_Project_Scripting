log_file="/tmp/expense.log"
color="\e[33m"


status_check() {
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
}


dnf module disable nodejs -y &>>$log_file
status_check
dnf module enable nodejs:18 -y &>>$log_file
status_check

dnf install nodejs -y &>>$log_file
status_check
cp backend.service /etc/systemd/system/backend.service &>>$log_file
status_check
useradd expense
status_check

mkdir /app &>>$log_file
status_check
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
status_check
cd /app &>>$log_file
status_check
unzip /tmp/backend.zip &>>$log_file
status_check

cd /app &>>$log_file
status_check

npm install &>>$log_file
status_check

dnf install mysql -y &>>$log_file
status_check

mysql -h mysql-dev.rdevops76.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
status_check

systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
status_check