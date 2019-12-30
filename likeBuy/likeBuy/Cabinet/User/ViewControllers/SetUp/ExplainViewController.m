//
//  ExplainViewController.m
//  likeBuy
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "ExplainViewController.h"
#import "NavigationView.h"

@interface ExplainViewController ()<NavigationViewDelegate>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)UITextView *textView;

@property(nonatomic, copy)NSString *userAgreement;
@property(nonatomic, copy)NSString *privacyClause;


@end

@implementation ExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:self.titleStr];
    [self.view addSubview:self.textView];
}


#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter / setter
-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

-(UITextView *)textView{
    if (_textView == nil) {
        CGFloat y = CGRectGetMaxY(self.navigationView.frame);
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(20, y, ScreenWidth - 40, ScreenHeight - y)];
        [_textView setEditable:NO];
        
    }
    return _textView;
}


-(NSString *)userAgreement{
    return @"用户协议\n尊敬的用户，欢迎使用由福建蹦豆网络科技有限公司（下列简称为“我们”或“豆会玩”）提供的服务。在使用前请您阅读如下服务协议，使用本应用即表示您同意接受本协议，本协议产生法律效力，特别涉及免除或者限制我们责任的条款，请仔细阅读。如有任何问题，可向我们咨询。\n\n \n 1. 服务条款的确认和接受\n 通过访问或使用本应用，表示用户同意接受本协议的所有条件和条款。\n 2. 服务条款的变更和修改\n 我们有权在必要时修改服务条款，服务条款一旦发生变更，将会在重要页面上提示修改内容。如果不同意所改动的内容，用户可以放弃获得的本应用信息服务。如果用户继续享用本应用的信息服务，则视为接受服务条款的变更。本应用保留随时修改或中断服务而不需要通知用户的权利。本应用行使修改或中断服务的权利，不需对用户或第三方负责。\n 3. 用户行为\n 3.1 用户账号、密码和安全\n 用户一旦注册成功，便成为豆会玩的合法用户，将得到一个密码和帐号。同时，此账号密码可登录豆会玩的所有网页和APP。因此用户应采取合理措施维护其密码和帐号的安全。用户对利用该密码和帐号所进行的一切活动负全部责任；由该等活动所导致的任何损失或损害由用户承担，我们不承担任何责任。 用户的密码和帐号遭到未授权的使用或发生其他任何安全问题，用户可以立即通知我们，并且用户在每次连线结束，应结束帐号使用，否则用户可能得不到我们的安全保护。对于用户长时间未使用的帐号，我们有权予以关闭并注销其内容。\n 3.2 账号注册时的禁止行为\n （1）请勿以党和国家领导人或其他社会名人的真实姓名、字号、艺名、笔名注册；\n （2）冒充任何人或机构，或以虚伪不实的方式谎称或使人误认为与任何人或任何机构有关的名称；\n （3）请勿注册和其他网友之名相近、相仿的名字；\n （4）请勿注册不文明、不健康名字，或包含歧视、侮辱、猥亵类词语的名字；\n （5）请勿注册易产生歧义、引起他人误解的名字；\n 3.3 用户在本应用上不得发布下列违法信息和照片：\n （1）反对宪法所确定的基本原则的；\n （2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n （3）损害国家荣誉和利益的；\n （4）煽动民族仇恨、民族歧视，破坏民族团结的；\n （5）破坏国家宗教政策，宣扬邪教和封建迷信的；\n （6）散布谣言，扰乱社会秩序，破坏社会稳定的；\n （7）散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；\n （8）侮辱或者诽谤他人，侵害他人合法权益的；\n （9）含有法律、行政法规禁止的其他内容的；\n （10）禁止骚扰、毁谤、威胁、仿冒网站其他用户；\n （11）严禁煽动非法集会、结社、游行、示威、聚众扰乱社会秩序；\n （12）严禁发布可能会妨害第三方权益的文件或者信息，例如（包括但不限于）：病毒代码、黑客程序、软件破解注册信息。\n （13）禁止上传他人作品。其中包括你从互联网上下载、截图或收集的他人的作品；\n （14）禁止上传广告、横幅、标志等网络图片；\n 4. 上传或发布的内容\n 用户上传的内容是指用户在豆会玩上传或发布的视频或其它任何形式的内容包括文字、图片、音频等。除非我们收到相关通知，否则用户视为其在本应用上传或发布的内容的版权拥有人。作为内容的发表者，需自行对所发表内容负责，因所发表内容引发的一切纠纷，由该内容的发表者承担全部法律及连带责任。我们不承担任何法律及连带责任。\n 对于经由本应用而传送的内容，我们不保证前述其合法性、正当性、准确性、完整性或品质。用户在使用本应用时，有可能会接触到令人不快、不适当或令人厌恶的内容。在任何情况下，我们均不对任何内容承担任何责任，包括但不限于任何内容发生任何错误或纰漏以及衍生的任何损失或损害。我们有权（但无义务）自行拒绝或删除经由本应用提供的任何内容。\n 个人或单位如认为我们存在侵犯自身合法权益的内容，应准备好具有法律效应的证明材料，及时与我们取得联系，以便我们迅速作出处理。";
}


-(NSString *)privacyClause{
    return @"隐私条款\n\n  1.用户信息公开情况说明\n 尊重用户个人隐私是我们的一项基本政策。所以，我们不会在未经合法用户授权时公开、编辑或透露其注册资料及保存在本应用中的非公开内容，除非有下列情况：\n （1）有关法律规定或我们合法服务程序规定；\n （2）在紧急情况下，为维护用户及公众的权益；\n （3）为维护我们的商标权、专利权及其他任何合法权益；\n （4）其他需要公开、编辑或透露个人信息的情况；\n 在以下（包括但不限于）几种情况下，我们有权使用用户的个人信息：\n （1）在进行促销或抽奖时，我们可能会与赞助商共享用户的个人信息，在这些情况下我们会在发送用户信息之前进行提示，并且用户可以通过不参与来终止传送过程；\n （2）我们可以将用户信息与第三方数据匹配；\n （3）我们会通过透露合计用户统计数据，向未来的合作伙伴、广告商及其他第三方以及为了其他合法目的而描述我们的服务；\n 2.隐私权政策适用范围\n （1）用户在登录本应用服务器时留下的个人身份信息；\n （2）用户通过本应用服务器与其他用户或非用户之间传送的各种资讯；\n （3）本应用与商业伙伴共享的其他用户或非用户的各种信息；\n 3.资讯公开与共享\n 我们不会将用户的个人信息和资讯故意透露、出租或出售给任何第三方。但以下情况除外：\n （1）用户本人同意与第三方共享信息和资讯;\n （2）只有透露用户的个人信息和资讯，才能提供用户所要求的某种产品和服务;\n （3）应代表本应用提供产品或服务的主体的要求提供（除非我们另行通知，否则该等主体无权将相关用户个人信息和资讯用于提供产品和服务之外的其他用途）：根据法律法规或行政命令的要求提供;因外部审计需要而提供;用户违反了本应用服务条款或任何其他产品及服务的使用规定;经本站评估，用户的帐户存在风险，需要加以保护。\n 4.Cookies、日志档案和webbeacon\n 通过使用cookies，本应用向用户提供简单易行并富个性化的网络体验。cookies能帮助我们确定用户连接的页面和内容，并将该等信息储存。我们使用自己的cookies和webbeacon，用于以下用途：\n （1）记住用户身份。例如：cookies和webbeacon有助于我们辨认用户作为我们的注册用户的身份，或保存用户向我们提供有关用户的喜好或其他信息；\n （2）分析用户使用我们服务的情况。我们可利用cookies和webbeacon来了解用户使用我们的服务进行什么活动、或哪些网页或服务最受欢迎； 我们为上述目的使用cookies和webbeacon的同时，可能将通过cookies和webbeacon收集的非个人身份信息汇总提供给广告商和其他伙伴，用于分析您和其他用户如何使用我们的服务并用于广告服务。用户可以通过浏览器或用户选择机制拒绝或管理cookies或webbeacon。但请用户注意，如果用户停用cookies或webbeacon，我们有可能无法为您提供最佳的服务体验，某些服务也可能无法正常使用。\n （3）当你使用本站的服务时，我们的主机会自动记录用户的浏览器在访问网站时所发送的信息和资讯。主机日志资讯包括但不限于用户的网路请求、IP地址、浏览器类型、浏览器使用的语言、请求的日期和时间，以及一个或多个可以对用户的浏览器进行辨识的cookie。\n 5.账户删除申请\n 用户有权在任何时候编辑用户在我们的帐户信息和资讯，用户也可以填写相关申请表格，要求删除个人帐户，但是用户无条件同意在你的帐户删除后，该帐户内及与该帐户相关的信息和资讯仍然保留在本网站档案记录中，除上述第三条规定的情况外，我们将为用户保密。\n";
}


-(void)setType:(NSInteger)type{
    if (type == 0) {
        [self.textView setText:self.userAgreement];
    }else{
        [self.textView setText:self.privacyClause];
    }
}

@end
