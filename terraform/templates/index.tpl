<!doctype html>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<title>sys-diplom-makhota</title>

	<style type="text/css">
		body {
			font-family: 'Lato', sans-serif;
			font-weight: 400;
			font-size: 16px;
			line-height: 1.7;
			color: #eee;
		}

		.header {
			height: 100vh;
			background-image: 
			linear-gradient(to right bottom, 
			rgba(76, 216, 255, 0.8),
			rgba(30, 108, 217, 0.8)),
			url('https://images.pexels.com/photos/213399/pexels-photo-213399.jpeg');
			
		background-size: cover;
			background-position: top;
			position: relative;

			clip-path: polygon(0 0, 100% 0, 100% 75vh, 0 100%);
		}

		.brand-box {
			position: absolute;
			top: 40px;
			left: 40px;
		}

		.brand { font-size: 20px; }

		.text-box {
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			text-align: center;
		}

		.heading-primary {
			color: #fff;
			text-transform: uppercase;

			backface-visibility: hidden;
			margin-bottom: 30px;
		}

		.heading-primary-main {
			display: block;
			font-size: 26px;
			font-weight: 400;
			letter-spacing: 5px;
		}

		.heading-primary-sub {
			display: block;
			font-size: 18px;
			font-weight: 700;
			letter-spacing: 7.4px;
		}

		.btn:link,
		.btn:visited {
			text-transform: uppercase;
			text-decoration: none;
			padding: 10px 20px;
			display: inline-block;
			border-radius: 100px;
			transition: all .2s;
			position: relative;
		}

		.btn:hover {
			transform: translateY(-3px);
			box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
		}

		.btn:active {
			transform: translateY(-1px);
			box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
		}

		.btn-white {
			background-color: #fff;
			color: #777;
			font-size: 14px;
		}


	</style>
</head>
<body>

<header class="header">
	
	<div class="text-box">
		<h1 class="heading-primary">
		<span class="heading-primary-main">Дипломная работа по профессии «Системный администратор»</span>
		<span class="heading-primary-sub">Елена Махота</span>
		</h1>
		<a href="http://${grafana_ip}:3000/" target="_blank" class="btn btn-white btn-animated">Grafana</a>
		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		<a  href="http://${kibana_ip}:5601" target="_blank" class="btn btn-white btn-animated">Kibana</a>
	</br>	</br>

	<h1 style="text-align: center;"><span class="heading-primary-sub"> Благодарю за обучение!</span></h1>
	</div>
	</header>



</body>
</html>