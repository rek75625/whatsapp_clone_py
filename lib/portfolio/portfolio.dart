import 'package:flutter/material.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  // Scroll controller
  final ScrollController _scrollController = ScrollController();

  // Keys for different sections
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  // ====================================================
  // SCROLL TO SECTION
  // ====================================================

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  // ====================================================
  // BUILD
  // ====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Mobile drawer
      drawer: _buildMobileDrawer(),

      body: Column(
        children: [
          // ---------------- NAVBAR ----------------
          _buildNavbar(),

          // ---------------- CONTENT ----------------
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // HOME
                  Container(key: homeKey, child: _buildHomeSection()),

                  // ABOUT
                  Container(key: aboutKey, child: _buildAboutSection()),

                  // SERVICES
                  Container(key: servicesKey, child: _buildServicesSection()),

                  // PORTFOLIO
                  Container(key: portfolioKey, child: _buildPortfolioSection()),

                  // SKILLS
                  Container(key: skillsKey, child: _buildSkillsSection()),

                  // CONTACT
                  Container(key: contactKey, child: _buildContactSection()),

                  // FOOTER
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================
  // NAVBAR
  // ====================================================

  Widget _buildNavbar() {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // LOGO
          const Text(
            'MyPortfolio',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),

          const Spacer(),

          // DESKTOP MENU
          LayoutBuilder(
            builder: (context, constraints) {
              // Hide menu on small screen
              if (MediaQuery.of(context).size.width < 800) {
                return Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                );
              }

              return Row(
                children: [
                  _navButton('Home', () => scrollToSection(homeKey)),

                  _navButton('About', () => scrollToSection(aboutKey)),

                  _navButton('Services', () => scrollToSection(servicesKey)),

                  _navButton('Portfolio', () => scrollToSection(portfolioKey)),

                  _navButton('Skills', () => scrollToSection(skillsKey)),

                  _navButton('Contact Us', () => scrollToSection(contactKey)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ====================================================
  // NAV BUTTON
  // ====================================================

  Widget _navButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
        ),
      ),
    );
  }

  // ====================================================
  // MOBILE DRAWER
  // ====================================================

  Widget _buildMobileDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35, color: Colors.blue),
                ),

                SizedBox(height: 10),

                Text(
                  'My Portfolio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          _drawerItem('Home', Icons.home, homeKey),

          _drawerItem('About', Icons.person, aboutKey),

          _drawerItem('Services', Icons.work, servicesKey),

          _drawerItem('Portfolio', Icons.folder, portfolioKey),

          _drawerItem('Skills', Icons.code, skillsKey),

          _drawerItem('Contact Us', Icons.email, contactKey),
        ],
      ),
    );
  }

  Widget _drawerItem(String title, IconData icon, GlobalKey key) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);

        Future.delayed(const Duration(milliseconds: 200), () {
          scrollToSection(key);
        });
      },
    );
  }

  // ====================================================
  // HOME SECTION
  // ====================================================

  Widget _buildHomeSection() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 600),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
      color: const Color(0xfff5f9ff),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool mobile = constraints.maxWidth < 700;

              if (mobile) {
                return Column(
                  children: [
                    _profileImage(),
                    const SizedBox(height: 40),
                    _homeText(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: _homeText()),

                  const SizedBox(width: 50),

                  Expanded(child: _profileImage()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ====================================================
  // HOME TEXT
  // ====================================================

  Widget _homeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello, I am',
          style: TextStyle(fontSize: 22, color: Colors.blue),
        ),

        const SizedBox(height: 10),

        const Text(
          'Your Name',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Flutter Developer',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'I create modern, responsive and user-friendly '
          'mobile and web applications using Flutter.',
          style: TextStyle(fontSize: 17, height: 1.6, color: Colors.black54),
        ),

        const SizedBox(height: 30),

        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                scrollToSection(contactKey);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
              child: const Text('Hire Me'),
            ),

            const SizedBox(width: 15),

            OutlinedButton(
              onPressed: () {
                scrollToSection(portfolioKey);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
              child: const Text('View Portfolio'),
            ),
          ],
        ),
      ],
    );
  }

  // ====================================================
  // PROFILE IMAGE
  // ====================================================

  Widget _profileImage() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.2),
              blurRadius: 30,
            ),
          ],
        ),
        child: const Icon(Icons.person, size: 170, color: Colors.blue),
      ),
    );
  }

  // ====================================================
  // ABOUT SECTION
  // ====================================================

  Widget _buildAboutSection() {
    return _sectionContainer(
      title: 'About Me',
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool mobile = constraints.maxWidth < 700;

          if (mobile) {
            return Column(
              children: [
                _aboutImage(),
                const SizedBox(height: 30),
                _aboutText(),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: _aboutImage()),

              const SizedBox(width: 50),

              Expanded(child: _aboutText()),
            ],
          );
        },
      ),
    );
  }

  Widget _aboutImage() {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Icon(Icons.code, size: 150, color: Colors.blue),
      ),
    );
  }

  Widget _aboutText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who Am I?',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

        Text(
          'I am a passionate Flutter developer who loves '
          'building beautiful and functional applications. '
          'I enjoy solving problems and learning new technologies.',
          style: TextStyle(fontSize: 17, height: 1.7, color: Colors.black54),
        ),

        SizedBox(height: 20),

        Text(
          'My goal is to create applications that are simple, '
          'fast, modern and easy to use.',
          style: TextStyle(fontSize: 17, height: 1.7, color: Colors.black54),
        ),
      ],
    );
  }

  // ====================================================
  // SERVICES
  // ====================================================

  Widget _buildServicesSection() {
    return _sectionContainer(
      title: 'My Services',
      child: LayoutBuilder(
        builder: (context, constraints) {
          int columns = 3;

          if (constraints.maxWidth < 900) {
            columns = 2;
          }

          if (constraints.maxWidth < 600) {
            columns = 1;
          }

          return GridView.count(
            crossAxisCount: columns,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
            children: [
              _serviceCard(
                Icons.phone_android,
                'Flutter App Development',
                'Build modern Android and iOS applications using Flutter.',
              ),

              _serviceCard(
                Icons.web,
                'Web Development',
                'Create responsive and modern websites using Flutter Web.',
              ),

              _serviceCard(
                Icons.design_services,
                'UI/UX Design',
                'Design beautiful and user-friendly application interfaces.',
              ),

              _serviceCard(
                Icons.api,
                'API Integration',
                'Connect applications with REST APIs and backend services.',
              ),

              _serviceCard(
                Icons.storage,
                'Database',
                'Work with Firebase, SQLite and other databases.',
              ),

              _serviceCard(
                Icons.bug_report,
                'Bug Fixing',
                'Find and solve errors in existing Flutter applications.',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _serviceCard(IconData icon, String title, String description) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue),

            const SizedBox(height: 15),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================
  // PORTFOLIO
  // ====================================================

  Widget _buildPortfolioSection() {
    return _sectionContainer(
      title: 'My Portfolio',
      child: LayoutBuilder(
        builder: (context, constraints) {
          int columns = 3;

          if (constraints.maxWidth < 900) {
            columns = 2;
          }

          if (constraints.maxWidth < 600) {
            columns = 1;
          }

          return GridView.count(
            crossAxisCount: columns,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.1,
            children: [
              _projectCard('E-Commerce App', Icons.shopping_cart),

              _projectCard('Chat Application', Icons.chat),

              _projectCard('Weather App', Icons.cloud),

              _projectCard('Education App', Icons.school),

              _projectCard('Food Delivery App', Icons.fastfood),

              _projectCard('Portfolio Website', Icons.language),
            ],
          );
        },
      ),
    );
  }

  Widget _projectCard(String title, IconData icon) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              child: Icon(icon, size: 80, color: Colors.blue),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================
  // SKILLS
  // ====================================================

  Widget _buildSkillsSection() {
    return _sectionContainer(
      title: 'My Skills',
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool mobile = constraints.maxWidth < 700;

          if (mobile) {
            return Column(children: _skillsList());
          }

          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _skillBar('Flutter', 0.90),
                    _skillBar('Dart', 0.85),
                    _skillBar('Firebase', 0.80),
                  ],
                ),
              ),

              const SizedBox(width: 50),

              Expanded(
                child: Column(
                  children: [
                    _skillBar('UI/UX Design', 0.75),
                    _skillBar('REST API', 0.80),
                    _skillBar('Git/GitHub', 0.85),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _skillsList() {
    return [
      _skillBar('Flutter', 0.90),
      _skillBar('Dart', 0.85),
      _skillBar('Firebase', 0.80),
      _skillBar('UI/UX Design', 0.75),
      _skillBar('REST API', 0.80),
      _skillBar('Git/GitHub', 0.85),
    ];
  }

  Widget _skillBar(String skill, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text('${(percentage * 100).toInt()}%'),
            ],
          ),

          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: percentage,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.grey.shade200,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  // ====================================================
  // CONTACT
  // ====================================================

  Widget _buildContactSection() {
    return _sectionContainer(
      title: 'Contact Us',
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool mobile = constraints.maxWidth < 700;

          if (mobile) {
            return Column(
              children: [
                _contactInformation(),
                const SizedBox(height: 40),
                _contactForm(),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _contactInformation()),

              const SizedBox(width: 50),

              Expanded(child: _contactForm()),
            ],
          );
        },
      ),
    );
  }

  Widget _contactInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let’s Work Together',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        const Text(
          'Have a project in mind? Feel free to contact me. '
          'I would love to discuss your idea.',
          style: TextStyle(fontSize: 17, color: Colors.black54, height: 1.6),
        ),

        const SizedBox(height: 30),

        _contactItem(Icons.email, 'Email', 'example@gmail.com'),

        _contactItem(Icons.phone, 'Phone', '+92 300 1234567'),

        _contactItem(Icons.location_on, 'Location', 'Pakistan'),
      ],
    );
  }

  Widget _contactItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 4),

              Text(value, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  // ====================================================
  // CONTACT FORM
  // ====================================================

  Widget _contactForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Your Name',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        const SizedBox(height: 15),

        TextField(
          decoration: InputDecoration(
            labelText: 'Your Email',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        const SizedBox(height: 15),

        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Your Message',
            alignLabelWithHint: true,
            prefixIcon: const Icon(Icons.message),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Message sent successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Send Message'),
          ),
        ),
      ],
    );
  }

  // ====================================================
  // COMMON SECTION CONTAINER
  // ====================================================

  Widget _sectionContainer({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              // SECTION TITLE
              Text(
                title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 50),

              child,
            ],
          ),
        ),
      ),
    );
  }

  // ====================================================
  // FOOTER
  // ====================================================

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: const Color(0xff101828),
      child: Column(
        children: [
          const Text(
            'MyPortfolio',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Flutter Developer | UI/UX Designer',
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook),

              _socialIcon(Icons.link),

              _socialIcon(Icons.email),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            '© 2026 Your Name. All Rights Reserved.',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  // ====================================================
  // DISPOSE
  // ====================================================

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
