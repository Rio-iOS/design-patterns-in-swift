@main
public struct chapter01_solid {
    public private(set) var text = "Hello, World!"

    public static func main() {
        let j = Journal()
        let _ = j.addEntry("I cried today")
        let bug = j.addEntry("I bought a bug")
        print(j)
        
        j.removeEntry(bug)
        print("===")
        print(j)
        
        let p = Persistence()
        let fileName = "example.txt"
        p.saveToFile(j, fileName, overwrite: false)
        
        
        // - MARK: Open Closed Principle
        let apple = Product(name: "Apple", color: .green, size: .small)
        let tree = Product(name: "tree", color: .green, size: .large)
        let house = Product(name: "House", color: .blue, size: .large)
        
        let products = [apple, tree, house]
       
        // bad fileter
        let pf = ProductFilter()
        print("Green products (old):")
        for p in pf.fileterByColor(products, .green) {
            print(" - \(p.name) is green.")
        }
        
        // good filter
        let bf = BetterFilter()
        print("Green products (new):")
        for p in bf.fileter(products, ColorSpecification(color: .green)) {
            print(" - \(p.name) is green.")
        }
        
        print("Large blue items")
        for p in bf.fileter(products, AndSpecification(first: ColorSpecification(color: .blue), second: SizeSpecification(size: .large))) {
            print(" - \(p.name) is blue and large.")
        }
    }
}
