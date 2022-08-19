module ToolipsDialogs
using Toolips
using ToolipsSession

#==
Dialog
    Base
==#
function dialog(c::Connection,
    name::String, x::String = 35percent, y::String = 20percent;
    label::String = "popup")
    maindia::Component{:dialog} = Component(name, "dialog")
    style!(maindia, "margin-left" => x, "margin-top" => y, "width" => 30percent,
    "position" => "fixed", "display" => "block", "background" => "transparent", "border-width" => 0px)
    # top bar
    topbar::Component{:div} = div("bar$name")
    topblabel::Component{:b} = Toolips.b(text = label, align = "center")
    style!(topblabel, "color" => "white", "display" => "inline-block", "margin-left" => 5px)
    xbutton::Component{:button} = button("topx$name", text = "X", align = "right")
    on(c, xbutton, "click") do cm::ComponentModifier
        remove!(cm, maindia)
    end
    style!(xbutton, "color" => "white", "background-color" => "red", "display" => "inline-block", "float" => "right",
    "border-radius" => 4px, "border-width" => 0px)
    style!(topbar,
    "background-color" => "blue", "border-radius" => 4px, "padding" => 1px, "border-width" => 0px)
    push!(topbar, topblabel, xbutton)
    # contents
    maindia[:children] = [topbar]
    contentarea::Component{:div} = div("content$name")
    style!(contentarea, "background-color" => "white", "border-radius" => "3px",
    "border-top" => "0px", "border-width" => 5px, "border-color" => "gray")
    push!(maindia, contentarea)
    maindia
end
#==
Dialogs
==#
function text_dialog(c::Connection, name::String; text::String = "text")
    d = dialog(c, name)
    mytp = p("text$name", text = text)
    push!(d[:children]["content$(d.name)"], mytp)
    d
end

export text_dialog
end # module
