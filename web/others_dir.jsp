<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="model.File" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.util.stream.Collectors" %>
<%--
  Created by IntelliJ IDEA.
  User: nullpo299
  Date: 18/11/28
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("USER");
    List<File> files = (List<File>) session.getAttribute("FILES");
    List<File> dirs = files.stream().filter(f -> f.isDirectory()).collect(Collectors.toList());
    List<File> normal = files.stream().filter(f -> !f.isDirectory()).collect(Collectors.toList());
    Path current = (Path) session.getAttribute("CURRENT");
%>

<html>

<head>
    <meta charset="utf-8">
    <title>MyDrive</title>
    <meta name="description" content="ファイル共有サービス">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="../css/others_dir.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("ul.menu li").mouseenter(function() {
                $(this).siblings().find("ul").hide();
                $(this).children().slideDown(150);
            });
            $('html').click(function() {
                $('ul.menu ul').slideUp(150);
            });
        });

    </script>
    <script type="text/javascript" src="../js/main.js"></script>
    <script type="text/javascript" src="../js/sort.js"></script>
    <script type="text/javascript">
        window.onload = function() {
            var dirs = [];
            var files = [];
            <%for (File f : dirs) {%>
            dirs.push(new Folder(<%="'"+f.getName()+"'"%>, 0, <%="'"+f.getPath()+"'"%>,<%="'"+f.isPublic()+"'"%>));
            <%}%>
            <%for (File f : normal) {%>
            files.push(new File(<%="'"+f.getName()+"'"%>, 1, <%="'"+f.getPath()+"'"%>,<%="'"+f.isPublic()+"'"%>));
            <%}%>
            sortLoad(dirs, files);
            loadBreadcrumb(<%="'"+current+"'"%>);
                                     
            var box = document.getElementById("content");
            box.addEventListener("contextmenu", function(e){
                    e.preventDefault();
                }, false);
        }
    </script>
</head>

<body>
    <header>
        <h1>
            <a href="https://auth.cyber-u.ac.jp/openam/UI/Login">
                <font class="M">M</font>y<font class="D">D</font>rive
            </a>
        </h1>

        <hr>
    </header>

    <div class="submenu" id="submenu"></div>

    <div class="wrapper">
        <div class="top_bar">
            <input type="submit" class="top_con login_con" value="ログアウト" onclick="jump('Logout','post')"> <input type="submit" class="top_con" value="設定" onclick="jump('Configuration','get')">
            <form action="#">
                <input id="topText" type="text" class="top_con" onkeyup="charFilter()" placeholder="ファイルの検索">
            </form>
        </div>
        <div class="side_bar">
            <ul>
                <li id="myFolder"><a href="#" onclick="jump('Main?req=home','post')">ホーム</a></li>
                <li id="serchUser"><a href="#" onclick="jump('Main?req=sear_user','post')">ユーザ検索</a></li>
                <li id="favorite"><a href="#" onclick="jump('Main?req=fav','post')">お気に入り</a></li>
                <li id="trush"><a href="#" onclick="jump('Main?req=trash','post')">ゴミ箱</a></li>
            </ul>
        </div>
        <div class="content" id="content">
            <div class="content_top_bar">
                <div class="content_top_bar_left">
                    <ul class="menu">
                        <li><a id="left_con" href="#" onclick="exeDownload()"><i class="material-icons"> cloud_download </i></a>
                            <div class="tooltips">ダウンロード</div>
                        </li>
                    </ul>
                </div>
                <div class="content_top_bar_right">
                    <ul class="menu">
                        <li><a id="right_con" href="#">ソート</a>
                            <ul id="ddmenu">
                                <li><a href="#" onclick="selectName();sortByName()"><span id="name">✓</span>名前順</a></li>
                                <li><a href="#" onclick="selectAsc()"><span id="asc">✓</span>昇順</a></li>
                                <li><a href="#" onclick="selectDesc()"><span id="desc">✓</span>降順</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="breadcrumb" id="breadcrumb">
            </div>
            <div id="main">
                <div class="node">
                    <img class="folder" src="../picture/folder.png">
                </div>
            </div>
            <div>
                <form id="hideForm" action="Main?req=home&method=post"></form>
            </div>
        </div>
    </div>
</body>

</html>

<%--<html>--%>
<%--<head>--%>
<%--<title>MyDrive</title>--%>
<%--</head>--%>
<%--<body>--%>

<%--<h1>MyDrive</h1>--%>
<%--<h2>My directories</h2>--%>

<%--<form action="Configuration" method="get">--%>
<%--<input type="submit" value="config">--%>
<%--</form>--%>
<%--<form action="Logout" method="post">--%>
<%--<input type="submit" value="logout">--%>
<%--</form>--%>
<%--<form action="Main?req=home" method="post">--%>
<%--<input type="submit" value="home">--%>
<%--</form>--%>
<%--<form action="Main?req=sear_user" method="post">--%>
<%--<input type="submit" value="sear_user">--%>
<%--</form>--%>
<%--<form action="Main?req=fav" method="post">--%>
<%--<input type="submit" value="fav">--%>
<%--</form>--%>
<%--<form action="Main?req=trash" method="post">--%>
<%--<input type="submit" value="trash">--%>
<%--</form>--%>
<%--<form enctype="multipart/form-data" action="Upload?path=<%=current%>" method="post">--%>
<%--<input type="file" name="file"><br>--%>
<%--<input type="submit" value="upload">--%>
<%--</form>--%>
<%--<form name="dl" action="Download" method="post">--%>
<%--<a href="#" onClick="dl.submit();">ダウンロード</a>--%>
<%--</form>--%>
<%--<form action="Main?req=mkdir&path=<%=current%>" method="post">--%>
<%--ディレクトリ名：<input type="text" name="name">--%>
<%--<input type="submit" value="create">--%>
<%--</form>--%>

<%--<%--%>
<%--out.println("BreadCrumbles<br>");--%>
<%--Path pos = current.getName(0);--%>
<%--for (int i = 1; i < current.getNameCount(); i++) {--%>
<%--out.println("<form action=\"Main?req=move&src=home&name=" + current.getName(i) +--%>
<%--"&path=" + src.relativize(src.resolve(pos)) +--%>
<%--" \"method=\"post\">");--%>
<%--out.println("<input type=\"submit\" value=\"" + current.getName(i) + "\">");--%>
<%--out.println("</form>");--%>
<%--if (current.getNameCount() - 1 != i)--%>
<%--out.println(" -> ");--%>
<%--pos = pos.resolve(current.getName(i));--%>
<%--}--%>
<%--out.println("<br>");--%>
<%--%>--%>

<%--<form action="Main?req=delete" method="post">--%>

<%--<%--%>
<%--out.println("Contents<br>");--%>
<%--int i = 0;--%>
<%--for (File f : files) {--%>
<%--out.println("<input type=\"checkbox\" name=\"check\" value=\"" + i++ + "\">");--%>
<%--if (Files.isDirectory(src.resolve(f.getPath()).resolve(f.getName()))) {--%>
<%--//                out.println("<a href=\"Main?req=move&src=home&name=" +--%>
<%--//                        f.getName() + "&path=" + f.getPath() + "\" method=\"post\">");--%>
<%--//                out.println("</form>");--%>
<%--} else {--%>
<%--out.println(f.getName());--%>
<%--}--%>
<%--}--%>
<%--%>--%>

<%--<input type="submit" value="delete">--%>
<%--</form>--%>

<%--<br>This is home.jsp!!!<br>--%>

<%--</body>--%>
<%--</html>--%>
