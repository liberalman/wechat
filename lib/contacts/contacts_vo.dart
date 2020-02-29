import 'package:flutter/material.dart';

class ContactVO {
  final String name;
  final String avatarUrl;
  final String seationKey;

  ContactVO({@required this.seationKey, this.name, this.avatarUrl});
}

List<ContactVO> contactData = [
  new ContactVO(seationKey: 'A', name: 'A家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'Andy', name: 'Andy', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'B', name: 'B家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'C', name: 'C家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'D', name: 'D家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'E', name: 'E家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'F', name: 'F家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'G', name: 'G家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'H', name: 'H家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'I', name: 'I家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),
  new ContactVO(seationKey: 'J', name: 'J家具销售', avatarUrl: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg'),

];