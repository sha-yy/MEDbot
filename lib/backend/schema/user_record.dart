import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_record.g.dart';

abstract class UserRecord implements Built<UserRecord, UserRecordBuilder> {
  static Serializer<UserRecord> get serializer => _$userRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'Fullname')
  String get fullname;

  @nullable
  @BuiltValueField(wireName: 'Age')
  String get age;

  @nullable
  @BuiltValueField(wireName: 'Gender')
  String get gender;

  @nullable
  @BuiltValueField(wireName: 'Address')
  String get address;

  @nullable
  @BuiltValueField(wireName: 'ProfilePic')
  String get profilePic;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserRecordBuilder builder) => builder
    ..fullname = ''
    ..age = ''
    ..gender = ''
    ..address = ''
    ..profilePic = ''
    ..email = ''
    ..displayName = ''
    ..uid = ''
    ..photoUrl = ''
    ..phoneNumber = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('User');

  static Stream<UserRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserRecord._();
  factory UserRecord([void Function(UserRecordBuilder) updates]) = _$UserRecord;

  static UserRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserRecordData({
  String fullname,
  String age,
  String gender,
  String address,
  String profilePic,
  String email,
  String displayName,
  String uid,
  DateTime createdTime,
  String photoUrl,
  String phoneNumber,
}) =>
    serializers.toFirestore(
        UserRecord.serializer,
        UserRecord((u) => u
          ..fullname = fullname
          ..age = age
          ..gender = gender
          ..address = address
          ..profilePic = profilePic
          ..email = email
          ..displayName = displayName
          ..uid = uid
          ..createdTime = createdTime
          ..photoUrl = photoUrl
          ..phoneNumber = phoneNumber));
