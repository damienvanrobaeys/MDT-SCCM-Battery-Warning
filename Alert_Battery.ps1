
[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\System.Windows.Interactivity.dll')       				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.IconPacks.dll')      | out-null  
[System.Reflection.Assembly]::LoadFrom('assembly\WpfAnimatedGif.dll')      | out-null  

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml("Alert_Battery.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

$Alert_Label = $Form.findname("Alert_Label") 
$Alert_Label2 = $Form.findname("Alert_Label2") 

$Global:Current_Folder = split-path $MyInvocation.MyCommand.Path

$XML_Config = "$Current_Folder\GUI_Config.xml"
[xml]$Get_Config = get-content $XML_Config

$Alert_Label.Content = $Get_Config.Config.Title
$Alert_Label2.Content = $Get_Config.Config.Text
$Form.Title = $Get_Config.Config.GUI_Title

$Form.add_MouseLeftButtonDown({
   $_.handled=$true
   $this.DragMove()
}) 
 

$Form.ShowDialog() | Out-Null

