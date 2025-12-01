import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'widgets/scroll_wheel_date_picker.dart';
import 'widgets/curve_scroll_wheel.dart';
import 'widgets/flat_scroll_wheel.dart';
import 'constants/date_constants.dart';

/// Helper function to check if date1 is on or before date2
bool _isOnOrBefore(DateTime date1, DateTime date2) {
  return date1.isBefore(date2) || _isSameDay(date1, date2);
}

/// Helper function to check if date1 is on or after date2
bool _isOnOrAfter(DateTime date1, DateTime date2) {
  return date1.isAfter(date2) || _isSameDay(date1, date2);
}

/// Helper function to check if two dates are the same day
bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}

/// Uses [ChangeNotifier] to listen to changes when the [changeMonth] or [changeYear] is called.
class DateController with ChangeNotifier {
  /// Responsible for handling the initialization & changes of the [_DayController], [_MonthController] & [_YearController].
  DateController({
    DateTime? initialDate,
    DateTime? startDate,
    DateTime? lastDate,
    bool hideOutOfRange = false,
  }) {
    _hideOutOfRange = hideOutOfRange;
    if (startDate != null && lastDate != null) {
      assert(_isOnOrBefore(startDate, lastDate), "Start date must be on or before last date.");
    }

    if (startDate != null && lastDate == null) {
      assert(_isOnOrBefore(startDate, DateTime.parse(defaultLastDate)), "Start date must be on or before default last date.");
    }

    if (startDate == null && lastDate != null) {
      assert(_isOnOrAfter(lastDate, DateTime.parse(defaultStartDate)), "Last date must be on or after default start date.");
    }

    if (startDate != null && initialDate != null) {
      assert(_isOnOrAfter(initialDate, startDate), "Initial date must be on or after the provided start date.");
    }

    if (startDate == null && initialDate != null) {
      assert(_isOnOrAfter(initialDate, DateTime.parse(defaultStartDate)), "Initial date must be on or after the default start date.");
    }

    if (startDate != null && initialDate == null) {
      assert(_isOnOrAfter(DateTime.now(), startDate), "Start date must be on or before the initial date or `DateTime.now()`.");
    }

    if (lastDate != null && initialDate != null) {
      assert(_isOnOrBefore(initialDate, lastDate), "Initial date must be on or before the provided last date.");
    }

    if (lastDate == null && initialDate != null) {
      assert(_isOnOrBefore(initialDate, DateTime.parse(defaultLastDate)), "Initial date must be on or before the default last date.");
    }

    if (lastDate != null && initialDate == null) {
      assert(_isOnOrBefore(DateTime.now(), lastDate), "Last date must be on or after the initial date or `DateTime.now()`.");
    }

    _initialDate = initialDate ?? DateTime.now();
    _startDate = startDate ?? DateTime.parse(defaultStartDate);
    _lastDate = lastDate ?? DateTime.parse(defaultLastDate);

    // Calculate initial number of days
    final int initYear = initialDate?.year ?? DateTime.now().year;
    final int initMonth = initialDate?.month ?? DateTime.now().month;
    int initNumberOfDays = _getNumberOfDays(year: initYear, month: initMonth - 1);
    int initStartDay = 1; // Default start day is 1
    
    // When hideOutOfRange is true, limit the number of days based on startDate and lastDate
    if (_hideOutOfRange) {
      // Check if we need to limit days from the start
      if (initYear == _startDate.year && initMonth == _startDate.month) {
        initStartDay = _startDate.day;
        initNumberOfDays = initNumberOfDays - _startDate.day + 1;
      }
      // Check if we need to limit days from the end
      if (initYear == _lastDate.year && initMonth == _lastDate.month) {
        initNumberOfDays = _lastDate.day - initStartDay + 1;
      }
    }

    _dayController = _DayController(
      selectedIndex: initialDate != null ? initialDate.day - initStartDay : null,
      numberOfDays: initNumberOfDays,
      startDay: initStartDay,
    );

    // Calculate initial number of months (reuse initYear from above)
    int initNumberOfMonths = 12;
    int initStartMonth = 1; // Default start month is 1 (January)
    
    // When hideOutOfRange is true, limit the number of months based on startDate and lastDate
    if (_hideOutOfRange) {
      // Check if we need to limit months from the start
      if (initYear == _startDate.year) {
        initStartMonth = _startDate.month;
        initNumberOfMonths = 12 - _startDate.month + 1;
      }
      // Check if we need to limit months from the end
      if (initYear == _lastDate.year) {
        initNumberOfMonths = _lastDate.month - initStartMonth + 1;
      }
    }

    _monthController = _MonthController(
      selectedIndex: initialDate != null ? initialDate.month - initStartMonth : null,
      numberOfMonths: initNumberOfMonths,
      startMonth: initStartMonth,
    );

    _yearController = _YearController(
      initialYear: initialDate?.year,
      startYear: startDate?.year,
      lastYear: lastDate?.year,
    );

    _dateTime = DateTime(
      initialDate?.year ?? DateTime.now().year,
      initialDate?.month ?? DateTime.now().month,
      initialDate?.day ?? DateTime.now().day,
    );

    if (_dateTime.year == _startDate.year) {
      _startMonth = _startDate.month - 1;
    }

    if (_dateTime.year == _lastDate.year) {
      _lastMonth = _lastDate.month;
    }

    if (_dateTime.month - 1 == _startDate.month - 1) {
      _startDay = _startDate.day - 1;
    }

    if (_dateTime.month == _lastDate.month) {
      _lastDay = _lastDate.day;
    }
  }

  /// Responsible for handling the days, months and years.
  late _DayController _dayController;
  late _MonthController _monthController;
  late _YearController _yearController;

  /// Returns a [DateTime] value when the [onSelectedItemChanged] of the [ScrollWheelDatePicker] is used.
  late DateTime _dateTime;

  /// Track the [initialDate], [startDate] and [lastDate] whenever the [DateController] is initialized or changed.
  late DateTime _initialDate;
  late DateTime _startDate;
  late DateTime _lastDate;

  /// Sets the starting month of the month items selection.
  int? _startMonth;

  /// Sets the last month of the month items selection.
  int? _lastMonth;

  /// Sets the starting day of the day items selection.
  int? _startDay;

  /// Sets the last day of the day items selection.
  int? _lastDay;

  /// Whether to hide dates outside the startDate and lastDate range.
  late bool _hideOutOfRange;

  IDateController get dayController => _dayController;
  IDateController get monthController => _monthController;
  IDateController get yearController => _yearController;
  DateTime get dateTime => _dateTime;
  int? get startMonth => _hideOutOfRange ? null : _startMonth;
  int? get lastMonth => _hideOutOfRange ? null : _lastMonth;
  int? get startDay => _hideOutOfRange ? null : _startDay;
  int? get lastDay => _hideOutOfRange ? null : _lastDay;

  /// Called when the selected item of the days [CurveScrollWheel] or [FlatScrollWheel] changed.
  void changeDay({required int day}) {
    _dayController = _dayController.copyWith(selectedIndex: day);

    // Calculate the actual day value based on startDay
    final int actualDay = _dayController.startDay + day;
    _dateTime = _dateTime.copyWith(day: actualDay);
  }

  /// Called when the selected item of the months [CurveScrollWheel] or [FlatScrollWheel] changed.
  void changeMonth({required int month}) {
    _monthController = _monthController.copyWith(selectedIndex: month);

    // Calculate the actual month value based on startMonth
    final int actualMonth = _monthController.startMonth + month;

    // Check if the current month and year is equal to the start date's month and year.
    // If so, change `_startDay` to the start date's day.
    // Otherwise, make it null.
    if (actualMonth == _startDate.month && _dateTime.year == _startDate.year) {
      _startDay = _startDate.day - 1;
    } else {
      _startDay = null;
    }

    // Check if the current month and year is equal to the last date's month and year.
    // If so, change `_lastDay` to the last date's day.
    // Otherwise, make it null.
    if (actualMonth == _lastDate.month && _dateTime.year == _lastDate.year) {
      _lastDay = _lastDate.day;
    } else {
      _lastDay = null;
    }

    // Preserve the current day before updating month
    final int currentDay = _dateTime.day;
    final int currentYear = _dateTime.year;

    // Update _dateTime with the new month BEFORE updating days
    _dateTime = _dateTime.copyWith(month: actualMonth);

    if (_hideOutOfRange) {
      // Recalculate and update month controller based on current year
      // This ensures that when user scrolls through months, the range is still respected
      int startMonth = 1;
      int numberOfMonths = 12;
      
      // Check if we need to limit months from the start
      if (currentYear == _startDate.year) {
        startMonth = _startDate.month;
        numberOfMonths = 12 - _startDate.month + 1;
      }
      
      // Check if we need to limit months from the end
      if (currentYear == _lastDate.year) {
        numberOfMonths = _lastDate.month - startMonth + 1;
      }
      
      // Validate that the current month is within bounds
      int validatedMonth = actualMonth;
      if (currentYear == _startDate.year && actualMonth < _startDate.month) {
        validatedMonth = _startDate.month;
      } else if (currentYear == _lastDate.year && actualMonth > _lastDate.month) {
        validatedMonth = _lastDate.month;
      }
      
      // Update month controller with validated values
      _monthController = _monthController.copyWith(
        selectedIndex: validatedMonth - startMonth,
        numberOfMonths: numberOfMonths,
        startMonth: startMonth,
      );
      
      // Update _dateTime with validated month
      _dateTime = _dateTime.copyWith(month: validatedMonth);
      
      // Update number of days based on the validated month
      final int currentMonth = validatedMonth;
      int totalDaysInMonth = _getNumberOfDays(year: currentYear, month: currentMonth - 1);
      int startDay = 1;
      int numberOfDays = totalDaysInMonth;
      
      // Check if we need to limit days from the start
      if (currentYear == _startDate.year && currentMonth == _startDate.month) {
        startDay = _startDate.day;
        numberOfDays = totalDaysInMonth - _startDate.day + 1;
      }
      // Check if we need to limit days from the end
      if (currentYear == _lastDate.year && currentMonth == _lastDate.month) {
        numberOfDays = _lastDate.day - startDay + 1;
      }
      
      // Determine the correct day and selectedIndex
      int finalDay = currentDay;
      int finalSelectedIndex;
      
      // Check if the current day is before startDay
      if (currentYear == _startDate.year && currentMonth == _startDate.month && currentDay < _startDate.day) {
        finalDay = _startDate.day;
        finalSelectedIndex = 0;
      }
      // Check if the current day is after the last available day
      else if (currentYear == _lastDate.year && currentMonth == _lastDate.month && currentDay > _lastDate.day) {
        finalDay = _lastDate.day;
        finalSelectedIndex = numberOfDays - 1;
      }
      // Check if the current day exceeds the total days in the month
      else if (currentDay > startDay + numberOfDays - 1) {
        finalDay = startDay + numberOfDays - 1;
        finalSelectedIndex = numberOfDays - 1;
      }
      // Otherwise, preserve the current day
      else {
        finalDay = currentDay;
        // Calculate selectedIndex based on the current day and startDay
        finalSelectedIndex = currentDay - startDay;
      }
      
      // Update day controller with the correct values
      _dayController = _dayController.copyWith(
        selectedIndex: finalSelectedIndex,
        numberOfDays: numberOfDays,
        startDay: startDay,
      );
      
      // Update _dateTime with the final day
      _dateTime = _dateTime.copyWith(day: finalDay);
    } else {
      // When hideOutOfRange is false, use the original logic
      _updateNumberOfDays(shouldNotify: false);
    }
    
    // Delay notification until after the current frame to avoid build conflicts
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  /// Called when a [MonthFormat] is given or changed in the [ScrollWheelDatePicker] constructor.
  void changeMonthFormat({required MonthFormat format}) {
    _monthController = _monthController.copyWith(monthFormat: format);
  }

  /// Called when the selected item of the years [CurveScrollWheel] or [FlatScrollWheel] changed.
  void changeYear({required int year}) {
    _yearController = _yearController.copyWith(selectedIndex: year);

    year = int.parse(_yearController.items[year]);

    // Check if the current year is equal to the start date's year.
    // If so, set the `_startMonth` to the start date's month.
    // Otherwise, make both `_startMonth` and `_startDay` null.
    if (year == _startDate.year) {
      _startMonth = _startDate.month - 1;

      // Check if the current month is equal to the start date's month.
      // If so, set the `_startDay` to the start date's day.
      // Otherwise, make it null.
      if (_dateTime.month == _startDate.month) {
        _startDay = _startDate.day - 1;
      } else {
        _startDay = null;
      }
    } else {
      _startMonth = null;
      _startDay = null;
    }

    // Check if the current year is equal to the last date's year.
    // If so, set the `_lastMonth` to the last date's month.
    // Otherwise, make both `_lastMonth` and `_lastDay` null.
    if (year == _lastDate.year) {
      _lastMonth = _lastDate.month;

      // Check if the current month is equal to the last date's month.
      // If so, set the `_lastDay` to the last date's day.
      // Otherwise, make it null.
      if (_dateTime.month == _lastDate.month) {
        _lastDay = _lastDate.day;
      } else {
        _lastDay = null;
      }
    } else {
      _lastMonth = null;
      _lastDay = null;
    }

    // When hideOutOfRange is true, update the number of months and validate current selection
    if (_hideOutOfRange) {
      int startMonth = 1;
      int numberOfMonths = 12;
      
      // Check if we need to limit months from the start
      if (year == _startDate.year) {
        startMonth = _startDate.month;
        numberOfMonths = 12 - _startDate.month + 1;
      }
      
      // Check if we need to limit months from the end
      if (year == _lastDate.year) {
        numberOfMonths = _lastDate.month - startMonth + 1;
      }
      
      // Calculate the current actual month based on the old month controller
      final int oldActualMonth = _monthController.startMonth + _monthController.selectedIndex;
      
      // Validate that the current month is within bounds for the new year
      int validatedMonth = oldActualMonth;
      if (year == _startDate.year && oldActualMonth < _startDate.month) {
        validatedMonth = _startDate.month;
      } else if (year == _lastDate.year && oldActualMonth > _lastDate.month) {
        validatedMonth = _lastDate.month;
      }
      
      // Ensure the validated month is within the new month range
      if (validatedMonth < startMonth) {
        validatedMonth = startMonth;
      } else if (validatedMonth > startMonth + numberOfMonths - 1) {
        validatedMonth = startMonth + numberOfMonths - 1;
      }
      
      // Update month controller with validated values
      _monthController = _monthController.copyWith(
        selectedIndex: validatedMonth - startMonth,
        numberOfMonths: numberOfMonths,
        startMonth: startMonth,
      );
      
      // Preserve the current day before updating
      final int currentDay = _dateTime.day;
      
      // Update _dateTime with the new year and validated month
      _dateTime = _dateTime.copyWith(year: year, month: validatedMonth);
      
      // Update number of days based on the new year and month
      final int currentYear = _dateTime.year;
      final int currentMonth = _dateTime.month;
      int totalDaysInMonth = _getNumberOfDays(year: currentYear, month: currentMonth - 1);
      int startDay = 1;
      int numberOfDays = totalDaysInMonth;
      
      // Check if we need to limit days from the start
      if (currentYear == _startDate.year && currentMonth == _startDate.month) {
        startDay = _startDate.day;
        numberOfDays = totalDaysInMonth - _startDate.day + 1;
      }
      // Check if we need to limit days from the end
      if (currentYear == _lastDate.year && currentMonth == _lastDate.month) {
        numberOfDays = _lastDate.day - startDay + 1;
      }
      
      // Determine the correct day and selectedIndex
      int finalDay = currentDay;
      int finalSelectedIndex;
      
      // Check if the current day is before startDay
      if (currentYear == _startDate.year && currentMonth == _startDate.month && currentDay < _startDate.day) {
        finalDay = _startDate.day;
        finalSelectedIndex = 0;
      }
      // Check if the current day is after the last available day
      else if (currentYear == _lastDate.year && currentMonth == _lastDate.month && currentDay > _lastDate.day) {
        finalDay = _lastDate.day;
        finalSelectedIndex = numberOfDays - 1;
      }
      // Check if the current day exceeds the total days in the month
      else if (currentDay > startDay + numberOfDays - 1) {
        finalDay = startDay + numberOfDays - 1;
        finalSelectedIndex = numberOfDays - 1;
      }
      // Otherwise, preserve the current day
      else {
        finalDay = currentDay;
        // Calculate selectedIndex based on the current day and startDay
        finalSelectedIndex = currentDay - startDay;
      }
      
      // Update day controller with the correct values
      _dayController = _dayController.copyWith(
        selectedIndex: finalSelectedIndex,
        numberOfDays: numberOfDays,
        startDay: startDay,
      );
      
      // Update _dateTime with the final day
      _dateTime = _dateTime.copyWith(day: finalDay);
    } else {
      // When hideOutOfRange is false, just update the year
      _dateTime = _dateTime.copyWith(year: year);
      // Update number of days without notifying listeners immediately
      _updateNumberOfDays(shouldNotify: false);
    }
    
    // Delay notification until after the current frame to avoid build conflicts
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  /// Handles the change of the total number of days base on the selected month.
  ///
  /// Responsible for updating the total number of days in the [CurveScrollWheel] or [FlatScrollWheel].
  ///
  /// Called when the [changeMonth] & [changeYear] is triggered.
  /// This is important so that the `total number of days` is updated when the month or year changes.
  void _updateNumberOfDays({bool shouldNotify = true}) {
    final int currentYear = int.parse(_yearController.items[_yearController.selectedIndex]);
    final int currentMonth = _monthController.items.indexOf(_monthController.items[_monthController.selectedIndex]) + _monthController.startMonth;
    
    int totalDaysInMonth = _getNumberOfDays(year: currentYear, month: currentMonth - 1);
    int startDay = 1;
    int numberOfDays = totalDaysInMonth;
    
    // When hideOutOfRange is true, limit the number of days based on startDate and lastDate
    if (_hideOutOfRange) {
      // Check if we need to limit days from the start
      if (currentYear == _startDate.year && currentMonth == _startDate.month) {
        startDay = _startDate.day;
        numberOfDays = totalDaysInMonth - _startDate.day + 1;
      }
      // Check if we need to limit days from the end
      if (currentYear == _lastDate.year && currentMonth == _lastDate.month) {
        numberOfDays = _lastDate.day - startDay + 1;
      }
    }

    final int selectedIndex = _dayController.selectedIndex >= numberOfDays ? numberOfDays - 1 : _dayController.selectedIndex;

    _dayController = _dayController.copyWith(
      selectedIndex: selectedIndex, 
      numberOfDays: numberOfDays,
      startDay: startDay,
    );

    if (shouldNotify) {
      notifyListeners();
    }
  }

  /// Called when the [initialDate] of the [ScrollWheelDatePicker] changed.
  void changeInitialDate(DateTime initialDate) {
    assert(_isOnOrAfter(initialDate, _startDate), "Initial date must be on or after the start date.");
    assert(_isOnOrBefore(initialDate, _lastDate), "Initial date must be on or before the last date.");

    _initialDate = initialDate;

    _dayController = _dayController.copyWith(
      selectedIndex: initialDate.day - 1,
      numberOfDays: _getNumberOfDays(
        year: initialDate.year,
        month: initialDate.month - 1,
      ),
    );
    _monthController = _monthController.copyWith(selectedIndex: initialDate.month - 1);
    _yearController = _yearController.copyWith(initialYear: initialDate.year);
  }

  /// Called when the [startDate] of the [ScrollWheelDatePicker] changed.
  void changeStartDate(DateTime startDate) {
    assert(_isOnOrBefore(startDate, _lastDate), "Start date must be on or before the last date.");
    assert(_isOnOrBefore(startDate, _initialDate), "Start date must be on or before the initial date.");

    _startDate = startDate;

    if (_dateTime.year == startDate.year) {
      _startMonth = _dateTime.month - 1;
    } else {
      _startMonth = null;
    }

    _yearController = _yearController.copyWith(startYear: startDate.year);
  }

  /// Called when the [lastDate] of the [ScrollWheelDatePicker] changed.
  void changeLastDate(DateTime lastDate) {
    assert(_isOnOrAfter(lastDate, _startDate), "Last date must be on or after the start date.");
    assert(_isOnOrAfter(lastDate, _initialDate), "Last date must be on or after the initial date.");

    _lastDate = lastDate;

    _yearController = _yearController.copyWith(lastYear: lastDate.year);
  }
}

/// Responsible for the configuration of the [ScrollWheelDatePicker]'s days scroll wheel.
class _DayController implements IDateController {
  /// A private constructor is needed in order to implement a factory method without including the list of [_days].
  ///
  /// This is a factor as well to create a [copyWith] & preventing other classes from creating a new list of [_days] outside of this class.
  const _DayController._({
    required int selectedIndex,
    required int numberOfDays,
    required int startDay,
    required List<String> days,
  })  : _selectedIndex = selectedIndex,
        _numberOfDays = numberOfDays,
        _startDay = startDay,
        _days = days;

  /// Currently selected index. Can be updated with [copyWith].
  final int _selectedIndex;

  /// Total number of days in a month. Can be updated with [copyWith].
  final int _numberOfDays;

  /// Starting day number (default is 1). Can be updated with [copyWith].
  final int _startDay;

  /// Collection of days in [String] type.
  final List<String> _days;

  @override
  int get selectedIndex => _selectedIndex;
  int get numberOfDays => _numberOfDays;
  int get startDay => _startDay;
  @override
  List<String> get items => _days;

  factory _DayController({int? selectedIndex, int? numberOfDays, int? startDay}) {
    final int start = startDay ?? 1;
    final List<String> days = _generateDays(
      numberOfDays: numberOfDays ?? _getNumberOfDays(year: DateTime.now().year, month: DateTime.now().month - 1),
      startDay: start,
    );

    return _DayController._(
      selectedIndex: selectedIndex ?? DateTime.now().day - start,
      numberOfDays: days.length,
      startDay: start,
      days: days,
    );
  }

  @override
  _DayController copyWith({
    int? selectedIndex,
    int? numberOfDays,
    int? startDay,
  }) =>
      _DayController(
        selectedIndex: selectedIndex ?? _selectedIndex,
        numberOfDays: numberOfDays ?? _numberOfDays,
        startDay: startDay ?? _startDay,
      );
}

/// Responsible for the configuration of the [ScrollWheelDatePicker]'s months scroll wheel.
class _MonthController implements IDateController {
  /// A private constructor is needed in order to implement a factory method without including the list of [_months].
  ///
  /// This is a factor as well to create a [copyWith] & preventing other classes from creating a new list of [_months] outside of this class.
  const _MonthController._({
    required MonthFormat monthFormat,
    required int selectedIndex,
    required int numberOfMonths,
    required int startMonth,
    required List<String> months,
  })  : _monthFormat = monthFormat,
        _selectedIndex = selectedIndex,
        _numberOfMonths = numberOfMonths,
        _startMonth = startMonth,
        _months = months;

  /// Currently selected index. Can be updated with [copyWith].
  final int _selectedIndex;

  /// Applies the format of the months. Can be updated with [copyWith].
  final MonthFormat _monthFormat;

  /// Total number of months to display. Can be updated with [copyWith].
  final int _numberOfMonths;

  /// Starting month number (1-12, default is 1 for January). Can be updated with [copyWith].
  final int _startMonth;

  /// Collection of months in [String] type.
  final List<String> _months;

  factory _MonthController({
    MonthFormat? monthFormat,
    int? selectedIndex,
    int? numberOfMonths,
    int? startMonth,
  }) {
    final MonthFormat format = monthFormat ?? MonthFormat.full;
    final int numMonths = numberOfMonths ?? 12;
    final int start = startMonth ?? 1;
    final List<String> months = _generateMonths(
      monthFormat: format,
      startMonth: start,
      numberOfMonths: numMonths,
    );

    return _MonthController._(
      monthFormat: format,
      selectedIndex: selectedIndex ?? DateTime.now().month - start,
      numberOfMonths: numMonths,
      startMonth: start,
      months: months,
    );
  }

  MonthFormat get monthFormat => _monthFormat;
  int get numberOfMonths => _numberOfMonths;
  int get startMonth => _startMonth;
  @override
  int get selectedIndex => _selectedIndex;
  @override
  List<String> get items => _months;

  @override
  _MonthController copyWith({
    MonthFormat? monthFormat,
    int? selectedIndex,
    int? numberOfMonths,
    int? startMonth,
  }) =>
      _MonthController(
        monthFormat: monthFormat ?? _monthFormat,
        selectedIndex: selectedIndex ?? _selectedIndex,
        numberOfMonths: numberOfMonths ?? _numberOfMonths,
        startMonth: startMonth ?? _startMonth,
      );
}

/// Responsible for the configuration of the [ScrollWheelDatePicker]'s years scroll wheel.
class _YearController implements IDateController {
  /// A private constructor is needed in order to implement a factory method without including the list of [_years].
  ///
  /// This is a factor as well to create a [copyWith] & preventing other classes from creating a new list of [_years] outside of this class.
  _YearController._({
    required int selectedIndex,
    required int startYear,
    required int lastYear,
    required List<String> years,
  })  : _selectedIndex = selectedIndex,
        _startYear = startYear,
        _lastYear = lastYear,
        _years = years;

  /// Currently selected index. Can be updated with [copyWith].
  final int _selectedIndex;

  /// Initial year of the items. Can be updated with [copyWith].
  final int _startYear;

  /// Max year of the items. Can be updated with [copyWith].
  final int _lastYear;

  /// Collection of years in [String] type.
  final List<String> _years;

  @override
  int get selectedIndex => _selectedIndex;
  int get startYear => _startYear;
  int get lastYear => _lastYear;
  @override
  List<String> get items => _years;

  factory _YearController({
    int? startYear,
    int? lastYear,
    int? selectedIndex,
    int? initialYear,
  }) {
    final int start = startYear ?? DateTime.parse(defaultStartDate).year;
    final int last = lastYear ?? DateTime.parse(defaultLastDate).year;

    final generatedYears = _generateYears(startYear: start, lastYear: last);

    if (initialYear != null) {
      selectedIndex = generatedYears.indexOf(initialYear.toString());
    } else {
      selectedIndex = selectedIndex;
    }

    return _YearController._(
      selectedIndex: selectedIndex ?? generatedYears.indexOf(DateTime.now().year.toString()),
      startYear: start,
      lastYear: last,
      years: generatedYears,
    );
  }

  @override
  _YearController copyWith({
    int? selectedIndex,
    int? startYear,
    int? lastYear,
    int? initialYear,
  }) =>
      _YearController(
        selectedIndex: selectedIndex ?? _selectedIndex,
        startYear: startYear ?? _startYear,
        lastYear: lastYear ?? _lastYear,
        initialYear: initialYear,
      );
}

/// Responsible for getting the total number of days on a particular [month].
///
/// The [year] is needed to determine if its a leap year or not.
///
/// If it is a leap year & [month] is [DateTime.february], return `29`.
///
/// Otherwise, return `28`.
int _getNumberOfDays({required int year, required int month}) {
  bool isLeapYear = false;

  if (month + 1 == DateTime.february) {
    isLeapYear = ((year % 4 == 0) && (year % 100 != 0)) || year % 400 == 0;
  }

  final List<int> daysInMonths = [31, isLeapYear ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  return daysInMonths[month];
}

/// Responsible for creating the list of daays in [String] type.
///
/// Requires [numberOfDays] to determine the total number of days to generate `from 1 to total number of days`.
///
/// If [startDay] is specified, it will be generate a total number of days starting from the given [startDay].
///
/// If [lastDay] is specified, it will be generate a total number of days ending with the given [lastDay].
List<String> _generateDays({required int numberOfDays, int startDay = 1}) {
  return List.generate(numberOfDays, (i) => (startDay + i).toString());
}

/// Responsible for creating the list of months in [String] type.
///
/// Requires a [MonthFormat] to determine what type of format to use to the list of months.
///
/// [MonthFormat.full] - Returns the full name of the months.
///
/// [MonthFormat.threeLetters] - Returns the three letters abbreviation name of the months.
///
/// [MonthFormat.twoLetters] - Returns the two letter abbreviation name of the months.
///
/// If [startMonth] is specified, it will generate the list of months starting from the given [startMonth].
///
/// If [lastMonth] is specified, it will generate the list of months ending with the given [lastMonth].
List<String> _generateMonths({required MonthFormat monthFormat, int startMonth = 1, int numberOfMonths = 12}) {
  switch (monthFormat) {
    case MonthFormat.threeLetters:
      return List.generate(numberOfMonths, (i) => _capitalize(Month.values[startMonth - 1 + i].threeAbv));
    case MonthFormat.twoLetters:
      return List.generate(numberOfMonths, (i) => _capitalize(Month.values[startMonth - 1 + i].twoAbv));
    default:
      return List.generate(numberOfMonths, (i) => _capitalize(Month.values[startMonth - 1 + i].name));
  }
}

/// Responsible for creating the list of years in [String] type.
///
/// Requires a [startYear] to determine the initial item of the list.
///
/// Requires a [lastYear] to determine the end item of the list.
List<String> _generateYears({required int startYear, required int lastYear}) {
  return List.generate((lastYear + 1) - startYear, (i) => (startYear + i).toString());
}

/// Ensures that the month's first letter is an upper case.
String _capitalize(String s) {
  return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
}

/// An abstract class for the [_DayController], [_MonthController] and [_YearController].
abstract interface class IDateController {
  IDateController copyWith();
  int get selectedIndex;
  List<String> get items;
}
