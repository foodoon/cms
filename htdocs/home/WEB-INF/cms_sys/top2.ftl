<script type="text/javascript">
    function g(o) {
        return document.getElementById(o);
    }
    function HoverLi(id) {
        $("li[id^='tb_']").each(function () {
            $(this).removeClass("current");
            $(this).addClass("normal");
        });
        $("#tb_" + id).removeClass("normal");
        $("#tb_" + id).addClass("current");
    }
    function countUnreadMsg() {
        $.post("message/v_countUnreadMsg.do", {
        }, function (data) {
            if (data.result) {
                $("#countDiv").html("" + data.count + "");
            } else {
                alert("<@s.m 'cmsMessage.noLogin'/>");
            }
        }, "json");
        setTimeout("countUnreadMsg() ", 1000 * 60 * 10);
    }
    $(function () {
        $('a').bind("focus", function () {
            $(this).blur();
        });
        countUnreadMsg();
    });
    setTimeout("countUnreadMsg() ", 1000 * 60 * 10);
    function mapDialog() {
        var result = window.showModalDialog("map.do", "", "dialogHeight:600px;dialogWidth:800px;center:yes;resizable: yes;");
        if (result != null) {
            var href = result.split(";")[0];
            var target = result.split(";")[1];
            if (target == "rightFrame") {
                window.parent.mainFrame.document.getElementById(target).src = href;
                var rightFrameSrc = window.parent.mainFrame.document.getElementById(target).src;
                if (rightFrameSrc.indexOf("frame") >= 0) {
                    window.parent.mainFrame.document.getElementById(target).src = rightFrameSrc.split("frame/")[0] + rightFrameSrc.split("frame/")[1];
                }
            }
            else {
                window.parent.document.getElementById(target).src = href;
            }
        }
    }
</script>
<div id="theme-setting">
    <a href="#"><i class="icon-gears icon-2x"></i></a>
    <ul>
        <li>
            <span>皮肤</span>
            <ul class="colors" data-target="body" data-prefix="skin-">
                <li class="active"><a class="blue" href="#"></a></li>
                <li><a class="red" href="#"></a></li>
                <li><a class="green" href="#"></a></li>
                <li><a class="orange" href="#"></a></li>
                <li><a class="yellow" href="#"></a></li>
                <li><a class="pink" href="#"></a></li>
                <li><a class="magenta" href="#"></a></li>
                <li><a class="gray" href="#"></a></li>
                <li><a class="black" href="#"></a></li>
            </ul>
        </li>
        <li>
            <span>导航</span>
            <ul class="colors" data-target="#navbar" data-prefix="navbar-">
                <li class="active"><a class="blue" href="#"></a></li>
                <li><a class="red" href="#"></a></li>
                <li><a class="green" href="#"></a></li>
                <li><a class="orange" href="#"></a></li>
                <li><a class="yellow" href="#"></a></li>
                <li><a class="pink" href="#"></a></li>
                <li><a class="magenta" href="#"></a></li>
                <li><a class="gray" href="#"></a></li>
                <li><a class="black" href="#"></a></li>
            </ul>
        </li>
        <li>
            <span>侧边栏</span>
            <ul class="colors" data-target="#main-container" data-prefix="sidebar-">
                <li class="active"><a class="blue" href="#"></a></li>
                <li><a class="red" href="#"></a></li>
                <li><a class="green" href="#"></a></li>
                <li><a class="orange" href="#"></a></li>
                <li><a class="yellow" href="#"></a></li>
                <li><a class="pink" href="#"></a></li>
                <li><a class="magenta" href="#"></a></li>
                <li><a class="gray" href="#"></a></li>
                <li><a class="black" href="#"></a></li>
            </ul>
        </li>
        <li>
            <span></span>
            <a data-target="navbar" href="#"><i class="icon-check-empty"></i> Fixed Navbar</a>
            <a class="pull-right visible-desktop" data-target="sidebar" href="#"><i class="icon-check-empty"></i> Fixed
                Sidebar</a>
        </li>
    </ul>
</div>
<!-- END Theme Setting -->
<!-- BEGIN Navbar -->
<div id="navbar" class="navbar">
<div class="navbar-inner">
<div class="container-fluid">
<!-- BEGIN Brand -->
<a href="#" class="brand">
    <small>
        <i class="icon-desktop"></i>
        为民网管理
    </small>
</a>
<!-- END Brand -->

<!-- BEGIN Responsive Sidebar Collapse -->
<a href="#" class="btn-navbar collapsed" data-toggle="collapse" data-target=".nav-collapse">
    <i class="icon-reorder"></i>
</a>
<!-- END Responsive Sidebar Collapse -->

<!-- BEGIN Navbar Buttons -->
<ul class="nav flaty-nav pull-right">
<!-- BEGIN Button Tasks -->
<li class="hidden-phone">
    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
        <i class="icon-tasks"></i>
        <span class="badge badge-warning">4</span>
    </a>

    <!-- BEGIN Tasks Dropdown -->
    <ul class="pull-right dropdown-navbar dropdown-menu">
        <li class="nav-header">
            <i class="icon-ok"></i>
            4 Tasks to complete
        </li>

        <li>
            <a href="#">
                <div class="clearfix">
                    <span class="pull-left">Software Update</span>
                    <span class="pull-right">75%</span>
                </div>

                <div class="progress progress-mini progress-warning">
                    <div style="width:75%" class="bar"></div>
                </div>
            </a>
        </li>

        <li>
            <a href="#">
                <div class="clearfix">
                    <span class="pull-left">Transfer To New Server</span>
                    <span class="pull-right">45%</span>
                </div>

                <div class="progress progress-mini progress-danger">
                    <div style="width:45%" class="bar"></div>
                </div>
            </a>
        </li>

        <li>
            <a href="#">
                <div class="clearfix">
                    <span class="pull-left">Bug Fixes</span>
                    <span class="pull-right">20%</span>
                </div>

                <div class="progress progress-mini">
                    <div style="width:20%" class="bar"></div>
                </div>
            </a>
        </li>

        <li>
            <a href="#">
                <div class="clearfix">
                    <span class="pull-left">Writing Documentation</span>
                    <span class="pull-right">85%</span>
                </div>

                <div class="progress progress-mini progress-success progress-striped active">
                    <div style="width:85%" class="bar"></div>
                </div>
            </a>
        </li>

        <li class="more">
            <a href="#">See tasks with details</a>
        </li>
    </ul>
    <!-- END Tasks Dropdown -->
</li>
<!-- END Button Tasks -->

<!-- BEGIN Button Notifications -->
<li class="hidden-phone">
    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
        <i class="icon-bell-alt"></i>
        <span class="badge badge-important">5</span>
    </a>

    <!-- BEGIN Notifications Dropdown -->
    <ul class="dropdown-navbar dropdown-menu">
        <li class="nav-header">
            <i class="icon-warning-sign"></i>
            5 Notifications
        </li>

        <li class="notify">
            <a href="#">
                <i class="icon-comment orange"></i>

                <p>New Comments</p>
                <span class="badge badge-warning">4</span>
            </a>
        </li>

        <li class="notify">
            <a href="#">
                <i class="icon-twitter blue"></i>

                <p>New Twitter followers</p>
                <span class="badge badge-info">7</span>
            </a>
        </li>

        <li class="notify">
            <a href="#">
                <img src="img/demo/avatar/avatar2.jpg" alt="Alex"/>

                <p>David would like to become moderator.</p>
            </a>
        </li>

        <li class="notify">
            <a href="#">
                <i class="icon-bug pink"></i>

                <p>New bug in program!</p>
            </a>
        </li>

        <li class="notify">
            <a href="#">
                <i class="icon-shopping-cart green"></i>

                <p>You have some new orders</p>
                <span class="badge badge-success">+10</span>
            </a>
        </li>

        <li class="more">
            <a href="#">See all notifications</a>
        </li>
    </ul>
    <!-- END Notifications Dropdown -->
</li>
<!-- END Button Notifications -->

<!-- BEGIN Button Messages -->
<li class="hidden-phone">
    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
        <i class="icon-envelope"></i>
        <span class="badge badge-success">3</span>
    </a>

    <!-- BEGIN Messages Dropdown -->
    <ul class="dropdown-navbar dropdown-menu">
        <li class="nav-header">
            <i class="icon-comments"></i>
            3 Messages
        </li>

        <li class="msg">
            <a href="#">
                <img src="img/demo/avatar/avatar3.jpg" alt="Sarah's Avatar"/>

                <div>
                    <span class="msg-title">Sarah</span>
                                            <span class="msg-time">
                                                <i class="icon-time"></i>
                                                <span>a moment ago</span>
                                            </span>
                </div>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore
                    et dolore magna aliqua.</p>
            </a>
        </li>

        <li class="msg">
            <a href="#">
                <img src="img/demo/avatar/avatar4.jpg" alt="Emma's Avatar"/>

                <div>
                    <span class="msg-title">Emma</span>
                                            <span class="msg-time">
                                                <i class="icon-time"></i>
                                                <span>2 Days ago</span>
                                            </span>
                </div>
                <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ...</p>
            </a>
        </li>

        <li class="msg">
            <a href="#">
                <img src="img/demo/avatar/avatar5.jpg" alt="John's Avatar"/>

                <div>
                    <span class="msg-title">John</span>
                                            <span class="msg-time">
                                                <i class="icon-time"></i>
                                                <span>8:24 PM</span>
                                            </span>
                </div>
                <p>Duis aute irure dolor in reprehenderit in ...</p>
            </a>
        </li>

        <li class="more">
            <a href="#">See all messages</a>
        </li>
    </ul>
    <!-- END Notifications Dropdown -->
</li>
<!-- END Button Messages -->

<!-- BEGIN Button User -->
<li class="user-profile">
    <a data-toggle="dropdown" href="#" class="user-menu dropdown-toggle">
        <img class="nav-user-photo" src="${base}/static/admin/img/admin/logo.png" alt="为民网管理控制台"/>
                                <span class="hidden-phone" id="user_info">
                                    <@s.ma code="global.admin.welcome" args=[user.username]/>
                                </span>
        <i class="icon-caret-down"></i>
    </a>

    <!-- BEGIN User Dropdown -->
    <ul class="dropdown-menu dropdown-navbar" id="user_menu">
        <li class="nav-header">
            <i class="icon-time"></i>
            Logined From 20:45
        </li>

        <li>
            <a href="#">
                <i class="icon-cog"></i>
                Account Settings
            </a>
        </li>

        <li>
            <a href="#">
                <i class="icon-user"></i>
                Edit Profile
            </a>
        </li>

        <li>
            <a href="#">
                <i class="icon-question"></i>
                Help
            </a>
        </li>

        <li class="divider visible-phone"></li>

        <li class="visible-phone">
            <a href="#" onclick="mapDialog()">【网站地图】</a>
            <a id="view_index" href="${site.url}" target="_blank"><@s.m "global.admin.viewFrontIndex"/></a>

        </li>
        <li class="visible-phone">
            <a href="#">
                <i class="icon-bell-alt"></i>
                Notifications
                <span class="badge badge-important">8</span>
            </a>
        </li>
        <li class="visible-phone">
            <a href="message/v_list.do" target="rightFrame">
                <i class="icon-envelope"></i>
                您有<span id="countDiv" class="badge badge-success"></span>条信息未读</a>
            </a>
        </li>

        <li class="divider"></li>

        <li>
            <a href="logout.do?returnUrl=index.do" target="_top" id="logout" onclick="return confirm('<@s.m "global.confirm.logout"/>');">
            <i class="icon-off"><@s.m "global.admin.logout"/></i>
            </a>
        </li>
    </ul>
    <!-- BEGIN User Dropdown -->
</li>
<!-- END Button User -->
</ul>
<!-- END Navbar Buttons -->
</div>
<!--/.container-fluid-->
</div>
<!--/.navbar-inner-->
</div>