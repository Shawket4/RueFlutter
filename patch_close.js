const fs = require('fs');
let code = fs.readFileSync('lib/features/shift/close_shift_screen.dart', 'utf8');

code = code.replace("import '../../shared/widgets/label_value.dart';", "import '../../shared/widgets/label_value.dart';\nimport '../../shared/widgets/top_bar.dart';");

const oldScaffold = `    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.go('/home')),
        title:            const Text('Close Shift'),
        backgroundColor:  Colors.white,
        elevation:        0,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: AppColors.border)),
        actions: [
          if (shift != null)
            _printing
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(width: 20, height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppColors.primary)))
                : IconButton(
                    icon:      const Icon(Icons.print_rounded),
                    tooltip:   'Print shift report',
                    onPressed: _printReport),
        ],
      ),
      body: shift == null
          ? const Center(child: Text('No open shift'))
          : isTablet ? _buildTablet(shift) : _buildPhone(shift),
    );`;

const newScaffold = `    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopBar(
            title: 'Close Shift',
            onBack: () => context.go('/home'),
            trailing: shift != null
                ? _printing
                    ? const SizedBox(
                        width: 38,
                        height: 38,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.primary),
                        ),
                      )
                    : GestureDetector(
                        onTap: _printReport,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.bg,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                            border: Border.all(color: AppColors.border),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.print_rounded,
                              size: 18, color: AppColors.textPrimary),
                        ),
                      )
                : null,
          ),
          Expanded(
            child: shift == null
                ? const Center(child: Text('No open shift'))
                : isTablet
                    ? _buildTablet(shift)
                    : _buildPhone(shift),
          ),
        ],
      ),
    );`;

code = code.replace(oldScaffold, newScaffold);

fs.writeFileSync('lib/features/shift/close_shift_screen.dart', code);
