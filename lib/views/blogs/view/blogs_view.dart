part of '../blogs.imports.dart';

class BlogsView extends StatefulWidget {
  const BlogsView({super.key});

  @override
  State<BlogsView> createState() => _BlogsViewState();
}

class _BlogsViewState extends State<BlogsView> {
  final BlogsViewModel vm = BlogsViewModel();

  @override
  void initState() {
    super.initState();
    vm.getBlogs();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const CustomText(text: MyStrings.blogs),centerTitle: true,),
      body: BlocBuilder<
        GenericCubit<List<BlogPost>>,
        GenericState<List<BlogPost>>
      >(
        bloc: vm.blogCubit,
        builder: (context, state) {
          if (state is GenericInitialState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GenericUpdateState) {
            final blogs = state.data;
            if (blogs.isEmpty) {
              return const Center(child: CustomText(text: MyStrings.noBlogs));
            }

            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return BlogsCard(
                  featureImage: blog.featuredImage,
                  creationTime: blog.creationTime,
                  title: blog.title,
                  shortContent: blog.shortContent,
                );
              },
            );
          }
          return const Center(child: CustomText(text: MyStrings.errorLoading));
        },
      ),
    );
}
