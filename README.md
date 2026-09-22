# lab02



##### Cấu trúc thư mục

* cau\_abcd
* cau\_efgh
* cau\_i1
* cau\_i2
* cau\_j



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

