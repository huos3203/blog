---
title: 定制开源的CLImageEditor图片编辑工具
date: 2019-06-13 22:19:57+0800 
updated: 2019-06-13 22:19:57+0800 
comments: true
---
### 定制图片编辑器
[关于Other Link Flag的有关说明](https://blog.csdn.net/cjh965063777/article/details/51880966)
```
other link 添加-ObjC
```
```puml
title 定制开源的CLImageEditor图片编辑工具
left header
在CLImageEditor基础之上，定制金和需求功能
1. 打包成公用组件JHImageEditorSDK.a
在CLImageEditor中使用类别，集成到主项目时，出现类的分别中的方法无法找到的问题。
需要配置other link，支持类的分别加载`-ObjC`
1. UI定制
2. 操作流程定制
开源库提供了两套Demo
第一个Demo：`CLImageEditorDemo`使用源码的demo
第二个Demo：`CocoapodsDemo`使用cocoapods管理依赖
endheader

scale 3.0

package "Demo"{
class "ViewController" as DemoVC 
}
'package，node，folder，frame，cloud，database'
package "JHImageEditorSDK" as jhsdk {

class "CLImageEditor" as editor {
    --属性组 --
    + CLImageEditorTheme *theme;
    + CLImageToolInfo *toolInfo;
    __构造器__
    #pragma mark - 金和
    + (id)initWithJHImage:
    + (id)initWithJHImage:delegate:
    + (id)initWithJHDelegate:
    --功能方法--
    + (void)refreshToolSettings;
}
class "CLImageEditorTheme" as theme {
    --属性组 --
    + id<CLImageEditorThemeDelegate> delegate;
    + NSString *bundleName;
    + UIColor  *backgroundColor;
    + UIColor  *toolbarColor;
    + NSString *toolIconColor;
    + UIColor  *toolbarTextColor;
    + UIColor  *toolbarSelectedButtonColor;
    + UIFont   *toolbarTextFont;
    + BOOL statusBarHidden;
    + UIStatusBarStyle statusBarStyle;
    __ 函数组__
    + (CLImageEditorTheme*)theme;
    + (CLToolbarMenuItem*)menuItemWithFrame:target:action:toolInfo:
}
class "CLImageToolInfo" as tool {
    --属性组 --
    + NSString *toolName;
    + NSString *title;
    + BOOL      available;
    + CGFloat   dockedNumber;
    + NSString *iconImagePath;
    + UIImage  *iconImage;
    + NSArray  *subtools;
    + NSMutableDictionary *optionalInfo;
    --辅助函数--
    - (NSString*)toolTreeDescription;
    - (NSArray*)sortedSubtools;
    --构造器--
    - (CLImageToolInfo*)subToolInfoWithToolName:recursive:
    + (CLImageToolInfo*)toolInfoForToolClass:
    - (CLImageToolInfo*)subToolInfoWithToolName:ecursive:
}
class "JHImageEditorViewController" as jheditorvc {
    --属性组 --
    - UIScrollView *menuView;
    - JHMenuToolBar *menuToolBar;
    - UIBarButtonItem *confirmBtn;
    - UIBarButtonItem *cancelBtn;
    __ geter函数组__
    - (UIToolBar*)UIToolBar
    - (UIBarButtonItem *)confirmBtn
    - (UIBarButtonItem *)cancelBtn
    --toolbar切换函数--
    //初始化toolbar
    - (void)installMenuToolBar
    //重装toolbar
    - (void)reloadMenuToolBar
    //底部toolbar功能切换方法
    - (void)swapToolBarWithEditing:(BOOL)editing
}
class "JHMenuToolBar" as JHBar {
    __ 函数组__
    //重写drawRect:删除toolbar的系统样式
    - (void) drawRect:(CGRect)rect
}
folder "ImageTools" as imgtools {

    class "CLImageToolBase" as basetool {
    }
    class "CLDrawTool" as drawtool {
    }
   folder "OptionalImageTools"{
    class "CLTextTool" as texttool {
    }
} 
}

basetool <|-- drawtool
basetool <|-- texttool


folder "ToolSettings" {
class "CLToolbarMenuItem" as CLmenuItem {
--属性组 --
    + NSString *title;
    + UIImage *iconImage;
    + UIViewContentMode iconImageContentMode;
    + BOOL selected;
    + UIImageView *iconView;
    --构造方法--
    - (id)initWithFrame:target:action:toolInfo:
    }
    class "CLImageToolInfo+Private" as infopr {
    + (NSArray*)toolsWithToolClass:
    }
    class "CLClassList" as clslist{
    + (NSArray*)subclassesOfClass:
    }
    class CLImageEditorTheme+Private 
}

Node "bundle"{

Node "CLImageEditor.Bundle" as b{
    folder "icon"{
        folder "black"{

        }

        folder "white"{

        }
    }
}
Node "JHImageEditor.Bundle" as jhb {

  }
  }
}
editor *-up-> DemoVC
editor <|-- jheditorvc
JHBar *-up-> jheditorvc:底部保存/上传按钮组类
CLmenuItem *-up-> jheditorvc: menuView中的菜单项类
theme *-up-> editor
tool *-up-> editor
theme -- CLmenuItem: <font color=red>**创建**</font>\n类方法获取菜单项实例
infopr *-up-> tool:<font color=red>**获取**</font>\n通过subTools获取某个菜单项实例\n定制菜单项实例的UI外观
infopr ..> clslist
theme ..> bundle 

CLmenuItem -down- imgtools

```

### 工具类图

```puml
title  画笔工具和文本批注工具
left header

endheader

folder "ImageTools" as imgtools {

    class "CLImageToolBase" as basetool {
        --属性组 --
        + _CLImageEditorViewController *editor;
        + CLImageToolInfo *toolInfo;
        --方法--
        - (id)initWithImageEditor:withToolInfo:
        - (void)setup;
        - (void)cleanup;
        - (void)executeWithCompletionBlock:(void(^)(UIImage *image, NSError *error, NSDictionary *userInfo))
        - (UIImage*)imageForKey:defaultImageName:
}
    class "CLDrawTool" as drawtool {
        --属性组 --
        + var :String=""
        __ 函数组__
        - (void)setup
        - (void)cleanup
        - (void)setMenu
    }
   folder "OptionalImageTools"{
    class "CLTextTool" as texttool {
        --属性组 --
        + var :String=""
        __ 函数组__
        + func (:,:)
    }
    
    class "CLCircleView" as circle{
        
    }
basetool <|-- drawtool
basetool <|-- texttool
circle *-up-> texttool:代码实现的放大缩小文本的控制手柄

}

```

