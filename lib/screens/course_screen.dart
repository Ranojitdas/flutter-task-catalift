import 'package:flutter/material.dart';
import '../constants/image_string.dart';
import '../models/course.dart';
import '../widgets/course_card.dart';

// Section Header Widget
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  const SectionHeader({Key? key, required this.title, this.onSeeAll})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF0A0A4A),
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text(
                "See All",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with SingleTickerProviderStateMixin {
  final Color primaryColor = const Color(0xFF0A0A4A);
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 2;

  final List<String> filters = [
    'All',
    'AI & ML',
    'Product',
    'Sales',
    'Public Speaking',
    'Engineering',
  ];

  final List<Course> featuredCourses = [
    Course(
      image: CourseImages.aiMlCourse,
      title: 'Artificial Intelligence and ML',
      lessons: 15,
      price: 1500,
    ),
    Course(
      image: CourseImages.uiUxCourse,
      title: 'User Interface and User Experience',
      lessons: 15,
      price: 1500,
    ),
    Course(
      image: CourseImages.computerEngineering,
      title: 'Computer Engineering',
      lessons: 15,
      price: 1500,
    ),
  ];

  final List<Course> popularCourses = [
    Course(
      image: CourseImages.webDevelopment,
      title: 'Web Development',
      lessons: 15,
      price: 1500,
    ),
    Course(
      image: CourseImages.mobileAppDev,
      title: 'Mobile App Development',
      lessons: 15,
      price: 1500,
    ),
    Course(
      image: CourseImages.dataScience,
      title: 'Data Science',
      lessons: 15,
      price: 1500,
    ),
  ];

  final List<Course> allCourses = [
    Course(
      image: CourseImages.dataScience,
      title: 'Data Science Fundamentals',
      lessons: 20,
      price: 2000,
    ),
    Course(
      image: CourseImages.mobileAppDev,
      title: 'Mobile App Development',
      lessons: 25,
      price: 2500,
    ),
    Course(
      image: CourseImages.webDevelopment,
      title: 'Web Development Bootcamp',
      lessons: 30,
      price: 3000,
    ),
  ];

  List<Course> get filteredCourses {
    List<Course> courses = allCourses;
    if (_searchQuery.isNotEmpty) {
      courses =
          courses
              .where(
                (course) => course.title.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
              )
              .toList();
    }
    if (_selectedFilter != 'All') {
      courses =
          courses
              .where(
                (course) => course.title.toLowerCase().contains(
                  _selectedFilter.toLowerCase(),
                ),
              )
              .toList();
    }
    return courses;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.7;

    Widget coursesPage = Column(
      children: [
        // Top blue bar with logo and icons
        Container(
          color: const Color(0xFF0A0A4A),
          padding: const EdgeInsets.only(
            top: 48,
            left: 20,
            right: 20,
            bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "CATALIFT",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  fontSize: 22,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.person_outline, color: Colors.white, size: 26),
                  SizedBox(width: 18),
                  Icon(Icons.notifications_none, color: Colors.white, size: 26),
                  SizedBox(width: 18),
                  Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Courses header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chevron_left,
                      color: Color(0xFF0A0A4A),
                      size: 32,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "Courses",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A0A4A),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: const Color(0xFF0A0A4A),
                      size: 24,
                    ),
                  ],
                ),
              ),
              // Search Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      suffixIcon: Icon(Icons.tune, color: Colors.grey[600]),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              if (_searchQuery.isEmpty) ...[
                // Featured For You
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Featured For You",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xFF0A0A4A),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: primaryColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                          child: const Text(
                            "See All",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredCourses.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  20 * (1 - _animationController.value),
                                ),
                                child: Opacity(
                                  opacity: _animationController.value,
                                  child: child,
                                ),
                              );
                            },
                            child: CourseCard(
                              course: featuredCourses[index],
                              width: cardWidth,
                            ),
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 32),
                // Most Popular
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Most Popular",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xFF0A0A4A),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: primaryColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                          child: const Text(
                            "See All",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Chips
                Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  20 * (1 - _animationController.value),
                                  0,
                                ),
                                child: Opacity(
                                  opacity: _animationController.value,
                                  child: child,
                                ),
                              );
                            },
                            child: FilterChip(
                              label: Text(
                                filters[index],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      _selectedFilter == filters[index]
                                          ? Colors.white
                                          : primaryColor,
                                ),
                              ),
                              selected: _selectedFilter == filters[index],
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFilter = filters[index];
                                });
                              },
                              selectedColor: primaryColor,
                              checkmarkColor: Colors.white,
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color:
                                      _selectedFilter == filters[index]
                                          ? Colors.transparent
                                          : Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              elevation: 0,
                              showCheckmark: false,
                            ),
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: popularCourses.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  20 * (1 - _animationController.value),
                                ),
                                child: Opacity(
                                  opacity: _animationController.value,
                                  child: child,
                                ),
                              );
                            },
                            child: CourseCard(
                              course: popularCourses[index],
                              width: cardWidth,
                            ),
                          ),
                        ),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              // All Courses or Search Results
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _searchQuery.isEmpty ? "All Courses" : "Search Results",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color(0xFF0A0A4A),
                        ),
                      ),
                      if (_searchQuery.isEmpty)
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: primaryColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                          child: const Text(
                            "See All",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredCourses.length,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              20 * (1 - _animationController.value),
                            ),
                            child: Opacity(
                              opacity: _animationController.value,
                              child: child,
                            ),
                          );
                        },
                        child: CourseCard(
                          course: filteredCourses[index],
                          width: double.infinity,
                          isHorizontal: true,
                        ),
                      ),
                    ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );

    List<Widget> pages = [
      Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      Center(
        child: Text(
          'Explore Mentors',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      coursesPage,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 12),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: const Color(0xFF0A0A4A),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            showUnselectedLabels: true,
            items: [
              _buildNavBarItem(Icons.home, 'Home', 0, _selectedIndex),
              _buildNavBarItem(
                Icons.edit,
                'Explore Mentors',
                1,
                _selectedIndex,
              ),
              _buildNavBarItem(Icons.menu_book, 'Courses', 2, _selectedIndex),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
    IconData icon,
    String label,
    int index,
    int selectedIndex,
  ) {
    final bool isSelected = index == selectedIndex;
    return BottomNavigationBarItem(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected)
            Container(
              width: 48,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAFE),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          Icon(icon, size: 28),
        ],
      ),
      label: label,
    );
  }
}
