class HospitalModel {
  String id, name, type, address, country, capacity, contact;
  String email, password;

  HospitalModel(
      {this.address,
      this.id,
      this.contact,
      this.country,
      this.name,
      this.capacity,
      this.type,
      this.email,
      this.password});
}
