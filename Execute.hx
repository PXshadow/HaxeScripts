function main()
{
    run(Sys.args()[0]);
}
function run(arg:String)
{
    switch(Sys.systemName())
    {
        case "Linux", "BSD": Sys.command("xdg-open", [arg]);
        case "Mac": Sys.command("open", [arg]);
        case "Windows": Sys.command("start", [arg]);
        default:
    }
}