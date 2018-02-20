<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 27.03.2016
 * Time: 01:20
 */


// Arayüzler bir sınıfta bulunması gereken fonksiyonların neler olacağını belirtir. Fonksiyonların görevleri
// arayüzden oluşturulan sınıflarda tanımlanırlar...
// Arayüzlerden nesne oluşturulamaz. implements ifadesi ile arayüzlerden yeni sınıflar oluşturulabilir.
// Arayüzlerden oluşturulan sınıflar içerisinde arayüzde bulunan tüm fonksiyonlar gerçeklenmelidir.
// Tüm fonksiyonlar public olmalıdır.


/*


To resume the idea (globally, not in detail):

inheritance

is the notion to extend from something, an optionnaly add some new feature or override some existing feature (to do differently). But using inheritance, you share a big part of code with the parent. You are a parent + some other things.

interface is representing some abilities (we says a class is implementing an interface to says that it has these abilities). An interface can be implemented by 2 classes which are completely different and do not share their code (except for methods they implements). When A and B are implementing interface C, A is not a B and B is not a A.

And one of the reason for interface is indeed to allow programmer to do the same as they could do with multi-inheritance, but without multi-inheritance problems.

This notion is used in some programming languages like JAVA, PHP...
----------------
An interface is a way of defining a contract. When we talk about abstract classes we are defining characteristics of an object type, specifying what an object is but in the case of an interface we define a capability and we bond to provide that capability, we are talking about establishing a contract about what the object can do.
------
Decission about when to use what is being arround for long and is one of those discussions with a lot of people having its opinion or backing up this or that idea. I think there's a basic rule that works almost everytime: Use abstract clases and inheritance if you can make the statement "A is a B". Use interfaces if you can make the statement "A is capable of [doing] as", or also, abstract for what a class is, interface for what a class can do.

Por example, we can say a triangle is a polygon but it makes no sense to say a triangle is capable of being a polygon.

Anyway, as ever, the rule of thumb for this is: use your common sense. Sometimes an interface just fit much better, even if the above rule tells you the contrary, if that's it just use the interface (after considering consequences of course).


*/
namespace cc;




interface VeritabaniArayuzu
{
    static function  insert($table, $entity); // soyut fonksiyonların gerçekleme kısmı bulunmaz
    //abstract public function ($kisi);
}