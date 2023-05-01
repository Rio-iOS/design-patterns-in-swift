@main
public struct chapter02_builder {
    public static func main() {
        /*
         Builderパターン
         - ビルダーは、オブジェクトを段階的に構築するためのAPIを提供するコンポーネント
         */
        
        let hello = "hello"
        var result = "<p>\(hello)</p>"
        print(result)
        
        let words = ["hello", "world"]
        result = "<ul>\n"
        for word in words {
            result.append("<li>\(word)</li>\n")
        }
        result.append("</ul>")
        print(result)
        
        // Builderパターンの利用
        let builder = HtmlBuilder(rootName: "ul")
        /*
        builder.addChild(name: "li", text: "hello")
        builder.addChild(name: "li", text: "word")
         */
        
        builder.addChildFluent(name: "li", text: "hello")
               .addChildFluent(name: "li", text: "world")
        print(builder.description)
        
        // faceted builder
        let pb = PersonBuilder()
        let p = pb
            .lives.at("123 London Road")
            .inCity("London")
            .withPostcode("SW12BC")
            .works.at("Fabrikam")
            .asA("Engineer")
            .earning(12300)
            .build()
        print(p)
    }
}

class HtmlElement: CustomStringConvertible {
    var name = ""
    var text = ""
    var elements = [HtmlElement]()
    private let indentSize = 2

    init(name: String = "", text: String = "") {
        self.name = name
        self.text = text
    }
    
    init(){}
    
    private func description(_ indent: Int) -> String {
        var result = ""
        let i = String(repeating: " ", count: indent)
        result += "\(i)<\(name)>\n"
        
        if !text.isEmpty {
            result += String(repeating: " ", count: (indent + 1))
            result += text
            result += "\n"
        }
        
        for e in elements {
            result += e.description(indent+1)
        }
        
        result += "\(i)</\(name)>\n"
        
        return result
    }
    
    public var description: String {
        return description(0)
    }
    
}

class HtmlBuilder: CustomStringConvertible {
    private let rootName: String
    var root = HtmlElement()
    
    init(rootName: String) {
        self.rootName = rootName
        root.name = rootName
    }
    
    func addChild(name: String, text: String) {
        let e = HtmlElement(name: name, text: text)
        root.elements.append(e)
    }
    
    // fluent builder
    // builderへの参照を返し続ける
    func addChildFluent(name: String, text: String) -> HtmlBuilder {
        let e = HtmlElement(name: name, text: text)
        root.elements.append(e)
        return self
    }
    
    var description: String {
        return root.description
    }
    
    func clear() {
        root = HtmlElement(name: rootName, text: "")
    }
}
