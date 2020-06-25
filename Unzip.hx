import sys.io.File;
import haxe.zip.Reader;
import sys.io.FileOutput;
import sys.FileSystem;
import haxe.io.Path;
import haxe.zip.Entry;
import haxe.ds.List;
function main()
{
    var args = Sys.args();
    if (args.length > 2 || args.length == 0) throw 'argument invalid ${args.length}, need [zip_path] optional: [unzip_path]';
    run(args[0],args[1]);
}
function run(zip:String,path:String="",list:List<Entry>=null,onComplete:Void->Void=null)
{
    path = Path.addTrailingSlash(path);
    var file:FileOutput = null;
    if (list == null) 
    {
        var input = File.read(zip);
        list = Reader.readZip(input);
        input.close();
    }
    trace('list ${list.length}');
    for (item in list)
    {
        trace('item ' + item);
        //i++;
        item.fileName = item.fileName.substring(item.fileName.indexOf("/") + 1,item.fileName.length);
        //trace("filename " + item.fileName + " c " + item.compressed + " d " + item.dataSize);
        if(Path.extension(item.fileName) == "")
        {
            //folder
            FileSystem.createDirectory(path + item.fileName);
            //worker.sendProgress(i);
        }else{
            if (FileSystem.isDirectory(path + Path.directory(item.fileName)))
            {
                file = File.write(path + item.fileName);
                file.write(haxe.zip.Reader.unzip(item));
                file.close();
                file = null;
            }else{
                trace("Can not find directory " + Path.directory(item.fileName));
            }
        }
    }
}