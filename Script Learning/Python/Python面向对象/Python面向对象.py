#!/usr/bin/python
# _*_ coding: UTF-8 _*_

#Python 面向对象
#Python从设计之初就已经是一门面向对象的语言，正因为如此，在Python中创建一个类和对象是很容易的。

#面向对象技术简介
#类(Class): 用来描述具有相同的属性和方法的对象的集合。它定义了该集合中每个对象所共有的属性和方法。对象是类的实例。
#类变量：类变量在整个实例化的对象中是公用的。类变量定义在类中且在函数体之外。类变量通常不作为实例变量使用。
#数据成员：类变量或者实例变量用于处理类及其实例对象的相关的数据。
#方法重写：如果从父类继承的方法不能满足子类的需求，可以对其进行改写，这个过程叫方法的覆盖（override），也称为方法的重写。
#实例变量：定义在方法中的变量，只作用于当前实例的类。
#继承：即一个派生类（derived class）继承基类（base class）的字段和方法。继承也允许把一个派生类的对象作为一个基类对象对待。例如，有这样一个设计：一个Dog类型的对象派生自Animal类，这是模拟"是一个（is-a）"关系（例图，Dog是一个Animal）。
#实例化：创建一个类的实例，类的具体对象。
#方法：类中定义的函数。
#对象：通过类定义的数据结构实例。对象包括两个数据成员（类变量和实例变量）和方法。

#创建类
#使用class语句来创建一个新类，class之后为类的名称并以冒号结尾，如下实例:
#class ClassName:
#    '类的帮助信息'   #类文档字符串
#        class_suite  #类体
#类的帮助信息可以通过ClassName.__doc__查看。
#class_suite 由类成员，方法，数据属性组成。
#实例

#创建员工的基类
class Employee:
    
    '所有员工的基类'
    
    empCount = 0

    def __init__(self, name, salary):
        self.name = name
        self.salary = salary
        Employee.empCount += 1

    def displayCount(self):
        '显示员工数量'
        print "Total employee %d" % Employee.empCount

    def displayEmployee(self):
        print "Name: ", self.name, ', salary: ', self.salary

#第一种方法__init__()方法是一种特殊的方法，被称为类的构造函数或初始化方法，当创建了这个类的实例时就会调用该方法

#创建实例对象
#要创建一个类的实例，你可以使用类的名称，并通过__init__方法接受参数。

#创建 Employee 类的第一个对象
emp1 = Employee("Zara", 10000)
#创建 Employee 类的第二个对象
emp2 = Employee("Manni", 5000)

#访问属性或方法
#您可以使用点(.)来访问对象的属性或方法。使用如下类的名称访问类变量:
emp1.displayEmployee()
emp2.displayEmployee()
emp2.displayCount()
print "Total employee %d" % Employee.empCount

#你可以添加，删除，修改类的属性，如下所示：
emp1.age = 23
print 'Name: ', emp1.name, ', age: ', emp1.age

del emp1.age

#你也可以使用以下函数的方式来访问属性：
#getattr(obj, name[, default]) : 访问对象的属性。
#hasattr(obj, name) : 检查是否存在一个属性。
#setattr(obj, name, value) : 设置一个属性。如果属性不存在，会创建一个新属性。
#delattr(obj, name) : 删除属性。
res = hasattr(emp1, 'age')    # 如果存在 'age' 属性返回 True。
if res == False:
    setattr(emp1, 'age', 8)   # 添加属性 'age' 值为 8
print getattr(emp1, 'age')    # 返回 'age' 属性的值
delattr(emp1, 'age')          # 删除属性 'age'

#Python内置类属性
#__dict__ : 类的属性（包含一个字典，由类的数据属性组成）
#__doc__ :类的文档字符串
#__name__: 类名
#__module__: 类定义所在的模块（类的全名是'__main__.className'，如果类位于一个导入模块mymod中，那么className.__module__ 等于 mymod）
#__bases__ : 类的所有父类构成元素（包含了以个由所有父类组成的元组）

print "Employee.__doc__", Employee.__doc__
print "Employee.__name__", Employee.__name__
print "Employee.__module__", Employee.__module__
print "Employee.__bases__", Employee.__bases__
print "Employee.__dict__", Employee.__dict__

#python对象销毁(垃圾回收)
#同Java语言一样，Python使用了引用计数这一简单技术来追踪内存中的对象。
#在Python内部记录着所有使用中的对象各有多少引用。
#一个内部跟踪变量，称为一个引用计数器。
#当对象被创建时， 就创建了一个引用计数， 当这个对象不再需要时， 也就是说， 这个对象的引用计数变为0 时， 它被垃圾回收。
#但是回收不是"立即"的， 由解释器在适当的时机，将垃圾对象占用的内存空间回收。

#实例
#析构函数 __del__ ，__del__在对象销毁的时候被调用，当对象不再被使用时，__del__方法运行：

class Point:

    '点类'

    def __init__(self, x = 0, y = 0):
        self.x = x
        self.y = y

    def __del__(self):
        class_name = self.__class__.__name__
        print class_name, "销毁"

pt1 = Point()
pt2 = pt1
pt3 = pt1
print id(pt1), id(pt2), id(pt3) # 打印对象的id
del pt1
del pt2
del pt3

#类的继承
#面向对象的编程带来的主要好处之一是代码的重用，实现这种重用的方法之一是通过继承机制。
#继承完全可以理解成类之间的类型和子类型关系。
#需要注意的地方：继承语法 class 派生类名（基类名）：
#//... 基类名写作括号里，基本类是在类定义的时候，在元组之中指明的。
#在python中继承中的一些特点：
#1：在继承中基类的构造（__init__()方法）不会被自动调用，它需要在其派生类的构造中亲自专门调用。
#2：在调用基类的方法时，需要加上基类的类名前缀，且需要带上self参数变量。
#区别于在类中调用普通函数时并不需要带上self参数
#3：Python总是首先查找对应类型的方法，如果它不能在派生类中找到对应的方法，它才开始到基类中逐个查找。
#（先在本类中查找调用的方法，找不到才去基类中找）。
#如果在继承元组中列了一个以上的类，那么它就被称作"多重继承" 。
#语法：
#派生类的声明，与他们的父类类似，继承的基类列表跟在类名之后，如下所示：
#class SubClassName (ParentClass1[, ParentClass2, ...]):
#    'Optional class documentation string'
#     class_suite

#你可以继承多个类
#class A:        # 定义类 A
#.....
#
#class B:         # 定义类 B
#.....
#
#class C(A, B):   # 继承类 A 和 B
#.....
#你可以使用issubclass()或者isinstance()方法来检测。
#issubclass() - 布尔函数判断一个类是另一个类的子类或者子孙类，语法：issubclass(sub,sup)
#isinstance(obj, Class) 布尔函数如果obj是Class类的实例对象或者是一个Class子类的实例对象则返回true。

class Parent:
    
    parentAttr = 100

    def __init__(self):
        print "调用父类的构造方法"

    def parentMethod(self):
        print "调用父类方法"

    def setAttr(self, attr):
        Parent.parentAttr = attr

    def getAttr(self):
        print "父类属性：", Parent.parentAttr

class Child(Parent):

    def __init__(self):
        print "调用子类构造方法"

    def childMethod(self):
        print '调用子类方法 child method'

c = Child()          # 实例化子类
c.childMethod()      # 调用子类的方法
c.parentMethod()     # 调用父类方法
c.setAttr(200)       # 再次调用父类的方法
c.getAttr()          # 再次调用父类的方法

#方法重写
#如果你的父类方法的功能不能满足你的需求，你可以在子类重写你父类的方法：
#实例：

class A:
    def myMethod(self):
        print '调用父类方法'

class B(A):
    def myMethod(self):
        print '调用子类方法'

b = B()
b.myMethod()

#基础重载方法
#下表列出了一些通用的功能，你可以在自己的类重写：
#序号	方法, 描述 & 简单的调用
#1	__init__ ( self [,args...] )
#构造函数
#简单的调用方法: obj = className(args)
#2	__del__( self )
#析构方法, 删除一个对象
#简单的调用方法 : dell obj
#3	__repr__( self )
#转化为供解释器读取的形式
#简单的调用方法 : repr(obj)
#4	__str__( self )
#用于将值转化为适于人阅读的形式
#简单的调用方法 : str(obj)
#5	__cmp__ ( self, x )
#对象比较
#简单的调用方法 : cmp(obj, x)

#运算符重载
#Python同样支持运算符重载，实例如下：

class Vector:

    def __init__(self, a, b):
        self.a = a
        self.b = b

    def __str__(self):
        return 'Vector (%d, %d)' % (self.a, self.b)

    def __add__(self, other):
        return Vector(self.a + other.a, self.b + other.b)

v1 = Vector(2, 10)
v2 = Vector(5, -2)
print v1 + v2

#类属性与方法
#类的私有属性
#__private_attrs：两个下划线开头，声明该属性为私有，不能在类地外部被使用或直接访问。
#在类内部的方法中使用时 self.__private_attrs。
#类的方法
#在类地内部，使用def关键字可以为类定义一个方法，与一般函数定义不同，类方法必须包含参数self,且为第一个参数
#类的私有方法
#__private_method：两个下划线开头，声明该方法为私有方法，不能在类地外部调用。
#在类的内部调用 self.__private_methods
#实例

class JustCounter:
    __secretCount = 0 #私有变量
    publicCount = 0   #公开变量

    def __count(self):
        self.__secretCount += 1
        self.publicCount = self.__secretCount
        print self.__secretCount

    def count(self):
        self.__count()

counter = JustCounter()
counter.count()
counter.count()
print counter.publicCount

#print counter.__secretCount
#Traceback (most recent call last):
#    File "Python面向对象.py", line 264, in <module>
#    print counter.__secretCount
#AttributeError: JustCounter instance has no attribute '__secretCount'

#counter.__count()
#Traceback (most recent call last):
#    File "Python面向对象.py", line 271, in <module>
#    counter.__count()
#AttributeError: JustCounter instance has no attribute '__count'


