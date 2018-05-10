<?php

/**
 * @return string
 */
function admin_log_title()
{
    return _('Log');
}

/**
 * @return string
 */
function admin_log()
{
    $filter = '';
    if (request()->has('keyword')) {
        $filter = strip_request_item('keyword');
    }
    $log_entries = LogEntries_filter($filter);

    foreach ($log_entries as &$log_entry) {
        $log_entry['date'] = date('d.m.Y H:i', $log_entry['timestamp']);
    }

    return page_with_title(admin_log_title(), [
        msg(),
        form([
            form_text('keyword', _('Search'), $filter),
            form_submit(_('Search'), 'Go')
        ]),
        table([
            'date'    => 'Time',
            'level'   => 'Type',
            'message' => 'Log Entry'
        ], $log_entries)
    ]);
}

function admin_export_emails_title() {
  return "Emails";
}

function admin_export_emails() {
  $html = '<div class="col-md-12"><h1>Emails</h1><pre>';
  foreach (Users() as $u) {
    $html .= "{$u['email']}\n";
  }
  $html .= "</pre></div>";
  return $html;
}

function next_partial_shifts_title() {
  return "Next understaffed shifts";
}

function next_partial_shifts() {
  $html = '<div class="col-md-12"><h1>' . next_partial_shifts_title() . '</h1>';

  $shifts = Shifts();

  $tabledata = [];

  foreach ($shifts as $s) {
    $needed = $taken = 0;
    $angels = [];
    foreach ($s['angeltypes'] as $at) {
      $needed += $at['count'];
      $taken += $at['taken'];
      foreach ($at['shift_entries'] as $entry) {
        $angels[] = '<a href="?p=users&action=view&user_id=' . $entry['UID'] . '">' . $entry['Nick'] . '</a>';
      }
    }
    if ($taken >= $needed) continue;
    if ($s['end'] < time()) continue;

    $tabledata[] = [
      'start' => $s['start'],
      'date' => '<span class="text-nowrap">' . date("Y-m-d", $s['start']) . '</span>',
      'time' => '<span class="text-nowrap">' . date("H:i", $s['start']) . " - " . date("H:i", $s['end']) . '</span>',
      'room' => $s['room_name'],
      'staff' => "<span class=\"badge alert-danger pull-left\" style=\"margin-right: 5px;\"><h5><strong>$taken / $needed</strong></h5></span> " . implode(', ', $angels),
      'info' => '<a href="' . shift_link($s) . '">' . $s['name'] . '</a><br />' .
                '<a href="' . shift_link($s) . '">' . $s['title'] . '</a>',
      'stuff' => var_export($angels, true),
    ];
  }

  $cmp = create_function('$a,$b', "return \$a['start'] > \$b['start'];");
  usort($tabledata, $cmp);
  
  return page_with_title(next_partial_shifts_title(), [
    msg(),
    table([
          'date' => _("Date"),
          'time' => _("Time"),
          'room' => _("Location"),
          'staff' => _("Current staff"),
          'info' => _("Task"),
    ], $tabledata)
  ]);
}

?>
