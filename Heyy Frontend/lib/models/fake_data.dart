import 'models.dart';

List<User> fakeuser = [
  User(
      name: "Rohit",
      profilePicture:
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDGc9LGF-9zXO38TWqOqRruKZLlwkWdkblPjmULMByAwmyXhPRFKd4Wj84_i7l_CNBBlsNa8uJq0t6ikxQEdR0p2DW4LulCkxNyfkMbWsI8lgGYjLcu5DEauy_BQsq25TYCkkhQgkJfvd-gXoPA9ijKGCV8ZButH3mhxAKt4-vKPB24etRBBskavAJ/s1600/1.webp",
      phone: "9541106654",
      email: "rohit23@gmail.com",
      preview: MessagePreview(
          message: "Kaha hai bhai?",
          time: "8:25",
          date: "20/7/2022",
          messageCount: "10")),
  User(
      name: "Riya",
      phone: "9345106654",
      email: "ria45@gmail.com",
      profilePicture:
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDGc9LGF-9zXO38TWqOqRruKZLlwkWdkblPjmULMByAwmyXhPRFKd4Wj84_i7l_CNBBlsNa8uJq0t6ikxQEdR0p2DW4LulCkxNyfkMbWsI8lgGYjLcu5DEauy_BQsq25TYCkkhQgkJfvd-gXoPA9ijKGCV8ZButH3mhxAKt4-vKPB24etRBBskavAJ/s1600/1.webp",
      preview: MessagePreview(
          message: "miss you",
          time: "13:25",
          date: "20/7/2022",
          messageCount: "5")),
  User(
      name: "Papa",
      phone: "8264406654",
      profilePicture:
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDGc9LGF-9zXO38TWqOqRruKZLlwkWdkblPjmULMByAwmyXhPRFKd4Wj84_i7l_CNBBlsNa8uJq0t6ikxQEdR0p2DW4LulCkxNyfkMbWsI8lgGYjLcu5DEauy_BQsq25TYCkkhQgkJfvd-gXoPA9ijKGCV8ZButH3mhxAKt4-vKPB24etRBBskavAJ/s1600/1.webp",
      email: "rajat456@gmail.com",
      preview: MessagePreview(
          message: "kab aayega",
          time: "13:25",
          date: "20/7/2022",
          messageCount: "1"))
];

List<StoryData> stories = [
  StoryData(
    username: "Riya",
    profilePicture:
        "https://308286-943399-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2022/03/stylish-whatsapp-dp-for-girls.png",
    stories: [
      const Story(
        url:
            'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
        mediaType: MediaType.video,
        date: "just now",
        caption: ":)",
        duration: Duration(seconds: 6),
      ),
      const Story(
        url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
        mediaType: MediaType.image,
        date: "2 hours ago",
        duration: Duration(seconds: 6),
      )
    ],
  ),
  StoryData(
    username: "Papa",
    profilePicture:
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDGc9LGF-9zXO38TWqOqRruKZLlwkWdkblPjmULMByAwmyXhPRFKd4Wj84_i7l_CNBBlsNa8uJq0t6ikxQEdR0p2DW4LulCkxNyfkMbWsI8lgGYjLcu5DEauy_BQsq25TYCkkhQgkJfvd-gXoPA9ijKGCV8ZButH3mhxAKt4-vKPB24etRBBskavAJ/s1600/1.webp",
    stories: [
      const Story(
        url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
        mediaType: MediaType.image,
        duration: Duration(seconds: 6),
        date: "2 hours ago",
      )
    ],
  ),
  StoryData(
    username: "Rohit",
    profilePicture:
        'https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL',
    stories: [
      const Story(
        url:
            'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
        mediaType: MediaType.image,
        duration: Duration(seconds: 10),
        date: "morning at 11:30",
      ),
      const Story(
        url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
        mediaType: MediaType.image,
        duration: Duration(seconds: 7),
        date: "morning at 8:30",
      )
    ],
  )
];
