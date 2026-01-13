var aiBatch03={};
aiBatch03.paramsFormat={
};
aiBatch03.fire=function(params){

	var ret = new Batch();
	ret.echo("開始 "+new Date().format("yyyy/MM/dd HH:mm:ss"));

	var now = new Date().format("HH:mm");

	// S3のロック解除：一定条件に満たせばアクセス可能、使用期間が無限である
	// S1とS2、ロック時間になったら、ロックを行う。
	// ロック時間帯になったら、ロックを行う。

	//  检索
	var selectResult = db.select(
		"SITE",
		"searchSiteList2",
		{
		}
	).getArray();

	for(var i = 0; i < selectResult.length; i ++){

		var site = selectResult[i]["site"];
		var div = selectResult[i]["div"];
		var status = selectResult[i]["status"];
		var complet_flg = selectResult[i]["complet_flg"];
		var locktimedaily = selectResult[i]["locktimedaily"];
		var locktimedailyFrom = locktimedaily.split("-")[0];
		var locktimedailyTo = locktimedaily.split("-")[1];


		var nextlocktime = selectResult[i]["nextlocktime"];

		if(div == 'S3' && complet_flg == '○' && status == 'locked'){

			if(locktimedailyFrom > locktimedailyTo){

				if(locktimedailyTo < now && now < locktimedailyFrom ){
					// ステータスを更新（locked ⇒ unlocked）
					db.change("SITE", "updateStatus1",
						{
							status : 'unlocked',
							site : site
						}
					);
				}

			}else if(locktimedailyFrom <= locktimedailyTo){

				if(locktimedailyTo < now || now < locktimedailyFrom ){
					// ステータスを更新（locked ⇒ unlocked）
					db.change("SITE", "updateStatus1",
						{
							status : 'unlocked',
							site : site
						}
					);
				}
			}


		}
		if(status == 'unlocked'){
			
			if(locktimedailyFrom > locktimedailyTo){
 				if(locktimedailyFrom <= now || now <= locktimedailyTo){
					// ステータスを更新（unlocked ⇒ locked）
					db.change("SITE", "updateStatus2",
						{
							status : 'locked',
							site : site
						}
					);
				}
			}else if(locktimedailyFrom <= locktimedailyTo){
 				if(locktimedailyFrom <= now && now <= locktimedailyTo ){
					// ステータスを更新（unlocked ⇒ locked）
					db.change("SITE", "updateStatus2",
						{
							status : 'locked',
							site : site
						}
					);
				}
			}

			if(nextlocktime != null && nextlocktime != ""){

				if(nextlocktime > "07:00"){
					if(now >= nextlocktime){
						// ステータスを更新（unlocked ⇒ locked）
						db.change("SITE", "updateStatus2",
							{
								status : 'locked',
								site : site
							}
						);
					}
				}else{
					if(now <= "07:00" && now >= nextlocktime){
						// ステータスを更新（unlocked ⇒ locked）
						db.change("SITE", "updateStatus2",
							{
								status : 'locked',
								site : site
							}
						);
					}

				}

			}

		}

		if(now >= "00:00" && now <= "00:01"){

			// 申請時間を0に変更
			db.change("SITE", "initApplyTime",
				{
				}
			);

		}

	}

	// "COM_システム情報"




	ret.echo("完了 "+new Date().format("yyyy/MM/dd HH:mm:ss"));

	return ret;
};
