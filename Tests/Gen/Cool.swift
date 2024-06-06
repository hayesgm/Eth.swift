struct Person {
    var lastName: String
    func withLastName(_ lastName: String) -> Person {
      var result = self
      result.lastName = lastName
      return result
    }
    var age: Int
    func withAge(_ age: Int) -> Person {
      var result = self
      result.age = age
      return result
    }
    var firstName: String
    func withFirstName(_ firstName: String) -> Person {
      var result = self
      result.firstName = firstName
      return result
    }
}