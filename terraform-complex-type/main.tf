terraform {
  
}

variable "collection_list" {
  type = list
  default = ["mars","moon","earth"]

}


variable "collection_map" {
  type = map
  default = {
      "PlanA" : "10 USD"
      "PlanB" : "20 USD"
  }
}

variable "structural_object" {
  type = object({ name=string, age=number })
  default = (
      {
          name : "John"
          age : 10
      }
  )
}

variable "structural_tuple" {
  type = tuple([string, number, bool])
  default = ["John",10,false]
}