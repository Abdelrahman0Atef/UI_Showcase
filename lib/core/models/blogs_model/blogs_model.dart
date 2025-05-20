import 'package:html/parser.dart' as html_parser;

class BlogPost {
  final String title;
  final String shortContent;
  final String featuredImage;
  final String creationTime;
  final int postId;
  final List<Category> categories;
  final List<RelatedPost> relatedPosts;

  BlogPost({
    required this.title,
    required this.shortContent,
    required this.featuredImage,
    required this.creationTime,
    required this.postId,
    required this.categories,
    required this.relatedPosts,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
      title: json['title'] ?? '',
      shortContent: removeHtmlTags(json['short_content'] ?? ''),
      featuredImage: json['featured_image'] ?? '',
      creationTime: json['creation_time'] ?? '',
      postId: json['post_id'] ?? '',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e))
          .toList() ?? [],
      relatedPosts: (json['related_posts'] as List<dynamic>?)
          ?.map((e) => RelatedPost.fromJson(e))
          .toList() ?? [],
    );

}

class Category {
  final String title;
  final int categoryId;

  Category({
    required this.title,
    required this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      title: json['title'] ?? '',
      categoryId: json['category_id'] ?? '',
    );
}

class RelatedPost {
  final String title;
  final String shortContent;
  final String featuredImage;
  final String creationTime;
  final int postId;

  RelatedPost({
    required this.title,
    required this.shortContent,
    required this.featuredImage,
    required this.creationTime,
    required this.postId,
  });

  factory RelatedPost.fromJson(Map<String, dynamic> json) => RelatedPost(
      title: json['title'] ?? '',
      shortContent: removeHtmlTags(json['short_content'] ?? ''),
      featuredImage: json['featured_image'] ?? '',
      creationTime: json['creation_time'] ?? '',
      postId: json['post_id'] ?? '',
    );
}

class BlogData {
  final List<BlogPost> blogPosts;

  BlogData({required this.blogPosts});

  factory BlogData.fromJson(Map<String, dynamic> json) => BlogData(
      blogPosts: (json['items'] as List<dynamic>)
          .map((e) => BlogPost.fromJson(e))
          .toList(),
    );
}

String removeHtmlTags(String htmlContent) {
  final document = html_parser.parse(htmlContent);
  final plainText = document.body?.text ?? '';
  return plainText;
}
