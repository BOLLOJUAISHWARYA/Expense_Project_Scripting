#Installing nginx
echo -e "\e[36m Nginx installation \e[0m"
dnf install nginx -y

echo -e "\e[36m Enabling and starting nginx \e[0m"
systemctl enable nginx
systemctl start nginx

echo -e "\e[36m clearing default nginx html  \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m Curling project  \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip


echo -e "\e[36m Extracting the project zip folder  \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[36m copying expense.conf from git to local  \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[36m Restart nginx  \e[0m"
systemctl restart nginx