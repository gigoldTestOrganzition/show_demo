//
//  User_SmallChange.h
//  gigold
//
//  Created by wsc on 15/11/5.
//  Copyright © 2015年 wsc. All rights reserved.
//

//用户收支明细

#import "BaseClass.h"

@interface User_SmallChange : BaseClass

@property (nonatomic, strong) NSString* acTyp;/* 账户种类 */

@property (nonatomic, strong) NSString* oldTxDt;/* 原始交易日期 */

@property (nonatomic, strong) NSString* oldTxTm;/* 原始交易时间 */

@property (nonatomic, strong) NSString* busTyp;/* 1业务类型 */

@property (nonatomic, strong) NSString* txTyp;/* 交易类型 */

@property (nonatomic, strong) NSString* ordTyp;// "0：远程消费01：充值02：提现03：缴话费04：缴公共事业费05：现场联机06：现场脱机07：圈存08：转账09：手工调账"
// /*订单类型*/
@property (nonatomic, strong) NSString* ordNo;// "通过订单类型和内部订单编号，可以连接到订单的详细信息查询" /*内部订单编号*/

@property (nonatomic, strong) NSString* sysCnl; /* 1系统渠道 */

@property (nonatomic, strong) NSString* capTyp;// 1：现金2：充值卡3：电子券6：专用支出/彩票返奖7：保证金" /*资金种类*/

@property (nonatomic, strong) NSString* ccy; /* 币种 */

@property (nonatomic, assign) NSInteger txAmt; /*1 对应原始金额 */

@property (nonatomic, assign) NSInteger drAmt; /* 支出金额 */

@property (nonatomic, assign) NSInteger crAmt;/* 收入金额 */

@property (nonatomic, assign) NSInteger odAmt; /* 透支金额 */

@property (nonatomic, assign) NSInteger bal;// 1"发生后总余额" /*余额*/

@property (nonatomic, assign) NSInteger canWdBal;// "发生后总余额" /*可用可提现余额*/

@end
