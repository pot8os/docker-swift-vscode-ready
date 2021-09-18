print("Hello, world!")

struct Stack<Element> {
  var items: [Element] = []
  mutating func push(_ item: Element) {
    items.append(item)
  }
  mutating func pop() -> Element {
    return items.removeLast()
  }
}

var stack = Stack<Int>()
stack.push(10)
stack.push(100)
stack.push(1000)
guard stack.pop() == 1000 else {
  fatalError()
}
guard stack.pop() == 100 else {
  fatalError()
}
print(stack.pop())
