//
//  DefinedEnums.h
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#ifndef DefinedEnums_h
#define DefinedEnums_h


typedef NS_ENUM(NSUInteger, NavigationType){
    
    NavigationNormalView = 0,
    NavigationHasGlassView = 10,
    NavigationDaXie = 20,
};

typedef NS_ENUM(NSUInteger, UserSelectItemType){
    UserSelectItemWodeDingDanType = 0,
    UserSelectItemWodeQianBaoType = 1,
    UserSelectItemShouyiBaoBiaoType = 2,
    UserSelectItemTuDuiType = 3,
    UserSelectItemFensiType = 4,
    UserSelectItemYaoQingType = 5,
    UserSelectItemShouCangType = 6,
    UserSelectItemZuJiType = 7,
    UserSelectItemHuiYuanType = 8,
    UserSelectItemChangJianType = 9,
    UserSelectItemTuiGuangType = 10,
    UserSelectItemWuLiaoType = 11,
    UserSelectItemXinShouType = 12,
    UserSelectItemShangWuType = 13,
    UserSelectItemGuanYuType = 14,
    UserSelectItemDiZhiType = 15,
    UserSelectItemLianXiRenType = 16,
    UserSelectItemZhaoHuiDingDanType = 17,

};

typedef NS_ENUM(NSUInteger, MeunSelectType){
    MeunSelectPDDType = 1,
    MeunSelectJDType = 2,
    MeunSelectCHAOSHIType = 3,
    MeunSelectTAOBAOType = 4,
    MeunSelectTIANMAOType = 5,
};

typedef NS_ENUM(NSUInteger, ListType){
    ListZongHeType = 10,
    ListXiaoLiangShangType = 20,
    ListXiaoLiangXiaType = 30,
    ListJiaGeShangType = 40,
    ListJiaGeXiaType = 50,
};


typedef NS_ENUM(NSUInteger, ViewControllerType){
    ViewControllerTop100Type = 10,
    ViewControllerJuHuaSuanType = 20,
    ViewController99BaoYouType = 30,
    ViewControllerXianShiType = 40,
    ViewControllerBaiCaiJiaType = 50,
    ViewControllerPinPaiQinCangType = 60,
    ViewControllerShiShiReXiaoType = 70,
};

typedef NS_ENUM(NSUInteger, LoadType){
    LoadTypeStart = 10,
    LoadTypeRefresh = 20,
    LoadTypeMoreData = 30,
};

typedef NS_ENUM(NSUInteger, EntranceType){
    
    EntrancePinddType = 101,
    EntranceJingdongType = 102,
    EntranceChaoShiType = 103,
    EntranceTaoBaoType = 104,
    EntranceTianMaoType = 105,
};


typedef NS_ENUM(NSInteger, JumpThirdPartyType){
    JumpThirdPartyTypeTianMaoXinPin = 10,
    JumpThirdPartyTypeFeiZhu = 20,
    JumpThirdPartyTypeJinRiBaoKuan = 30,
    JumpThirdPartyTypeELeM = 40,
    JumpThirdPartyTypeTianMaoGuoJi = 50,
    JumpThirdPartyTypeTianMaoChaoShi = 60
};


#endif /* DefinedEnums_h */
