<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="ru">
<head>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
    <title>Lab2</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<table>
    <%@ include file="incl/header.jsp" %>
    <tr>
        <td>
            <form method="GET" action="${pageContext.request.contextPath}/app" onsubmit="return valid()">
                <input type="hidden" name="unique" value="<%= UUID.randomUUID().toString()%>">
                <table class="form">
                    <tr>
                        <td>
                            <p>Значение X:
                                <input type="radio" name="X" value="-2" id="X0">
                                <label for="X0">-2</label>
                                <input type="radio" name="X" value="-1.5" id="X1">
                                <label for="X1">-1.5</label>
                                <input type="radio" name="X" value="-1" id="X2">
                                <label for="X2">-1</label>
                                <input type="radio" name="X" value="-0.5" id="X3">
                                <label for="X3">-0.5</label>
                                <input type="radio" name="X" value="0" id="X4">
                                <label for="X4">0</label>
                                <input type="radio" name="X" value="0.5" id="X5">
                                <label for="X5">0.5</label>
                                <input type="radio" name="X" value="1" id="X6">
                                <label for="X6">1</label>
                                <input type="radio" name="X" value="1.5" id="X7">
                                <label for="X7">1.5</label>
                                <input type="radio" name="X" value="2" id="X8">
                                <label for="X8">2</label>
                            </p>
                        </td>
                    </tr>
                    <tr class="Blue">
                        <td>
                            <p>
                                <label for="textfieldY">Значение Y ∈ (-5;3):</label>
                                <input type="text" id="textfieldY" autocomplete="off" name="Y">
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>
                                Значение R:
                                <input type="radio" name="R" value="1" id="R0">
                                <label for="R0">1</label>
                                <input type="radio" name="R" value="2" id="R1">
                                <label for="R1">2</label>
                                <input type="radio" name="R" value="3" id="R2">
                                <label for="R2">3</label>
                                <input type="radio" name="R" value="4" id="R3">
                                <label for="R3">4</label>
                                <input type="radio" name="R" value="5" id="R4">
                                <label for="R4">5</label>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>
                                <input type="submit" value="Отправить">
                            </p>
                            <div id="error"></div>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
    <%@ include file="incl/table.jsp" %>
    <tr>
        <td id="stand_deviation"></td>
    </tr>
</table>
<script src="${pageContext.request.contextPath}/javascript/validation.js"></script>
<script type="text/javascript">
    let form = document.forms[0];
    let Relems = form.elements.R;
    Array.prototype.forEach.call(Relems, function (elem) {
       elem.oninput = function (event) {
           console.log(event);
           let newR = event.currentTarget.value;
           paintPlot();
           console.log(newR);
           addDots(newR, data);
       }
    });
    canvas.onclick = function (event) {
        const x = event.pageX;
        const y = event.pageY;

    };
</script>
</body>
</html>