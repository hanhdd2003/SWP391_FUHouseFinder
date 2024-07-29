<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Cập Nhật Nhà</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .error {
            color: red;
            font-size: 0.875em;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Cập Nhật Thông Tin Nhà</h1>
    <form id="updateHouseForm" action="update_house" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="house_id" value="${house.id}">

        <div class="form-group">
            <label for="address">Địa Chỉ</label>
            <input type="text" class="form-control" id="address" name="address" value="${house.address}" required maxlength="255">
            <div id="addressError" class="error"></div>
        </div>
        <div class="form-group">
            <label for="description_house">Mô Tả</label>
            <textarea class="form-control" id="description_house" name="description_house" rows="3" required maxlength="255">${house.descriptionHouse}</textarea>
            <div id="descriptionHouseError" class="error"></div>
        </div>
        <div class="form-group">
            <label for="status">Trạng Thái</label>
            <input type="text" class="form-control" id="status" name="status" value="${house.status}" required maxlength="255">
            <div id="statusError" class="error"></div>
        </div>
       
        <button type="submit" class="btn btn-primary btn-block">Cập Nhật</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function validateForm() {
        let isValid = true;
        
        // Clear previous error messages
        document.getElementById('addressError').innerText = '';
        document.getElementById('descriptionHouseError').innerText = '';
        document.getElementById('statusError').innerText = '';

        // Get form values
        const address = document.getElementById('address').value;
        const descriptionHouse = document.getElementById('description_house').value;
        const status = document.getElementById('status').value;

        // Validate address
        if (address === '') {
            document.getElementById('addressError').innerText = 'Địa chỉ là bắt buộc.';
            isValid = false;
        } else if (address.length > 255) {
            document.getElementById('addressError').innerText = 'Địa chỉ không được vượt quá 255 ký tự.';
            isValid = false;
        }

        // Validate description
        if (descriptionHouse === '') {
            document.getElementById('descriptionHouseError').innerText = 'Mô tả là bắt buộc.';
            isValid = false;
        } else if (descriptionHouse.length > 255) {
            document.getElementById('descriptionHouseError').innerText = 'Mô tả không được vượt quá 255 ký tự.';
            isValid = false;
        }

        // Validate status
        if (status === '') {
            document.getElementById('statusError').innerText = 'Trạng thái là bắt buộc.';
            isValid = false;
        } else if (status.length > 255) {
            document.getElementById('statusError').innerText = 'Trạng thái không được vượt quá 255 ký tự.';
            isValid = false;
        }

        return isValid;
    }
</script>
</body>
</html>
