
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <title>Upload Image</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }
        .file-upload-wrapper {
            position: relative;
            width: 300px;
            height: 50px;
            background: #007BFF;
            border-radius: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            overflow: hidden;
        }
        .file-upload-wrapper input[type="file"] {
            position: absolute;
            opacity: 0;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        .file-upload-text {
            pointer-events: none;
        }
    </style>
</head>
<body>
    <h2>Upload Image</h2>
    <form action="UploadServlet" method="post" enctype="multipart/form-data">
        <div class="file-upload-wrapper">
            <span class="file-upload-text">Choose a file</span>
            <input type="file" name="avatar" id="file-upload">
        </div>
        <input type="submit" value="Upload">
    </form>

    <script>
        const fileInput = document.getElementById('file-upload');
        const fileUploadText = document.querySelector('.file-upload-text');

        fileInput.addEventListener('change', function () {
            if (this.files.length > 0) {
                fileUploadText.textContent = this.files[0].name;
            } else {
                fileUploadText.textContent = 'Choose a file';
            }
        });
    </script>
</body>
</html>
