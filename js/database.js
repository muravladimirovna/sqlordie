$(document).ready(function() {	
	db = openDatabase("sqlex", "0.1", "A list of to do items.", 200000);
	if(!db){ alert("Failed to connect to database."); }
	db.transaction(function(tx) {
		tx.executeSql("DROP TABLE IF EXISTS `pc`;", [], function(result){}, function(tx, error){
			console.log(error);
		});
		tx.executeSql("CREATE TABLE IF NOT EXISTS `pc` ( `code` int(11) NOT NULL, `model` varchar(50) NOT NULL, `speed` smallint(6) NOT NULL, `ram` smallint(6) NOT NULL, `hd` double NOT NULL, `cd` varchar(10) NOT NULL, `price` decimal(12,2) DEFAULT NULL, PRIMARY KEY (`code`) );", [], function(result){}, function(tx, error){
			console.log(error)
		});
		tx.executeSql("INSERT INTO `pc` (`code`, `model`, `speed`, `ram`, `hd`, `cd`, `price`) VALUES (1, '1232', 500, 64, 5, '12x', 600.00), (2, '1121', 750, 128, 14, '40x', 850.00), (3, '1233', 500, 64, 5, '12x', 600.00), (4, '1121', 600, 128, 14, '40x', 850.00), (5, '1121', 600, 128, 8, '40x', 850.00), (6, '1233', 750, 128, 20, '50x', 950.00), (7, '1232', 500, 32, 10, '12x', 400.00), (8, '1232', 450, 64, 8, '24x', 350.00), (9, '1232', 450, 32, 10, '24x', 350.00), (10, '1260', 500, 16, 10, '12x', 250.00), (11, '1233', 900, 128, 40, '40x', 980.00), (12, '1233', 800, 128, 20, '50x', 970.00);", [], function(result){}, function(tx, error){
			console.log(error)
		});
	});
	db.transaction(function(tx) {
		tx.executeSql("SELEXT * FROM `pc`;", [], function(result){
			console.log(result);
		}, function(tx, error){
			console.log(error);
		});
	});
});
