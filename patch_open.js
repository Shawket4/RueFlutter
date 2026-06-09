const fs = require('fs');
let code = fs.readFileSync('lib/features/shift/open_shift_screen.dart', 'utf8');

code = code.replace("import '../../shared/widgets/card_container.dart';", "import '../../shared/widgets/card_container.dart';\nimport '../../shared/widgets/top_bar.dart';");

const oldScaffold = `    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.go('/home')),
        title: const Text('Open Shift'),
        elevation: 0,
        backgroundColor: AppColors.bg,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(`;

const newScaffold = `    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopBar(
            title: 'Open Shift',
            onBack: () => context.go('/home'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(`;

code = code.replace(oldScaffold, newScaffold);

code = code.replace(/          \),\n        \),\n      \),\n    \);\n  \}\n\}/, "          ),\n        ),\n      ),\n      ],\n    );\n  }\n}");

fs.writeFileSync('lib/features/shift/open_shift_screen.dart', code);
