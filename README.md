
petty-pay->petty-pay.xcodeproj  

CocoaPodsのインストール  

MacにはデフォでRubyがインストールされているので、それ前提です。  
1.ruby gemを最新にする  
$ sudo gem update --system  
2.インストール  
$ sudo gem install cocoapods  
3.セットアップ  
$ pod setup  
Setting up CocoaPods master repo  
Setup completed (read-only access)  

=================== 
CocoaPodsをつかう  
1.使いたいプロジェクトファイルに移動  
->pettypay  
2.ライブラリのインストール  
$ pod install  
Analyzing dependencies  
Downloading dependencies  
Using AFNetworking (2.2.1)  
Generating Pods project  
Integrating client project  
※注意  
この時にxcodeでプロジェクトファイルを開いていると、  
[!] From now on use `testProject.xcworkspace`.  
と怒られてしまうので、xcodeを閉じてから実行する。  
3.確認  
実行したプロフェクトファイルにtestProject.xcworkspaceというファイルが作成されるので、  
xcodeprojではなく、こっちを開き、実行する。  
4.他のライブラリをインストールするときは？  
さっきのPodfileにライブラリを追加し、  
$ pod update  
を実行する。


