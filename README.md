# lab02



##### Cấu trúc thư mục

* cau\_abcd

  * screentshots
* cau\_efgh

  * screentshots
* cau\_i1

  * screentshots
* cau\_i2

  * screentshots
* cau\_j

  * screentshots



Mỗi người về tạo 1 thư mục screenshots trong thư mục câu tương ứng của mình nha 



###### **Quy trình cho các thành viên khác**



Mỗi thành viên làm theo flow tương tự:



\# 1. Clone dự án



git clone https://github.com/mkalab/lab02.git

cd lab02



\# 2. Tạo mới và checkout sang branch của mình

git checkout -b <ten\_thanh\_vien>/<thu\_muc>



\# ví dụ thành viên 2

git checkout -b ngoc/cau\_efgh



\# 3. Kiểm tra, lưu thay đổi và push lên Remote

git status

git add <thu\_muc>

git commit -m "..."

git push origin <ten\_thanh\_vien>/<thu\_muc>



\# ví dụ thành viên 2

git status

git add cau\_efgh/

git commit -m "..."

git push origin ngoc/cau\_efgh hoặc git push -u origin ngoc/cau\_efgh



Ở lần push đầu tiên của một nhánh mới, nếu dùng thêm flag -u, những lần sau chỉ cần git push là xong





###### **Để tránh gặp sự cố tương thích giữa các phiên bản, cả nhóm chỉ cần lưu ý 2 điều:**



* KHÔNG gửi/đẩy file Backup CSDL (.bak): SQL Server không cho phép bản cũ khôi phục (restore) file .bak được tạo từ bản mới hơn (ví dụ: máy dùng SQL Server 2019 không thể mở file .bak xuất từ máy dùng SQL Server 2025).
* KHÔNG đẩy file dữ liệu (.mdf, .ldf): Đây là các file CSDL gốc của máy cá nhân, không nên đưa vào Repository GitHub.

