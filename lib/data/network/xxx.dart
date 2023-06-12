class Singleton {
  // 创建一个静态变量，用于存储单例对象
  static final Singleton _singleton = Singleton._internal();

  // 创建一个工厂方法，返回单例对象
  factory Singleton() {
    return _singleton;
  }

  // 创建一个内部构造方法，这样可以防止外部直接创建对象
  Singleton._internal() {
    // 在这里进行初始化配置
    // ...
  }

// 你可以在这里添加你的实例方法和变量
// ...
}
