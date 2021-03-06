<?php

use Engelsystem\ShiftCalendarRenderer;
use Engelsystem\ShiftsFilterRenderer;

/**
 *
 * @param array                 $room
 * @param ShiftsFilterRenderer  $shiftsFilterRenderer
 * @param ShiftCalendarRenderer $shiftCalendarRenderer
 * @return string
 */
function Room_view($room, ShiftsFilterRenderer $shiftsFilterRenderer, ShiftCalendarRenderer $shiftCalendarRenderer)
{
    global $user;

    $assignNotice = '';
    if (config('signup_requires_arrival') && !$user['Gekommen']) {
        $assignNotice = info(render_user_arrived_hint(), true);
    }

    $description = '';
    if (!empty($room['description'])) {
        $description = '<h3>' . _('Description') . '</h3>';
        $parsedown = new Parsedown();
        $description .= '<div class="well">' . $parsedown->parse($room['description']) . '</div>';
    }

    $tabs = [];
    if (!empty($room['map_url'])) {
        $tabs[_('Map')] = sprintf(
            '<div class="map">'
            . '<iframe style="width: 100%%; min-height: 400px; border: 0 none;" src="%s"></iframe>'
            . '</div>',
            $room['map_url']
        );
    }

    $tabs[_('Shifts')] = div('first', [
        $shiftsFilterRenderer->render(page_link_to('rooms', [
            'action'  => 'view',
            'room_id' => $room['RID']
        ])),
        $shiftCalendarRenderer->render()
    ]);

    $selected_tab = 0;
    $request = request();
    if ($request->has('shifts_filter_day')) {
        $selected_tab = count($tabs) - 1;
    }

    return page_with_title(glyph('map-marker') . $room['Name'], [
        $assignNotice,
        $description,
        tabs($tabs, $selected_tab)
    ]);
}

/**
 *
 * @param array $room
 * @return string
 */
function Room_name_render($room)
{
    global $privileges;

    if (in_array('view_rooms', $privileges)) {
        return '<a href="' . room_link($room) . '">' . glyph('map-marker') . $room['Name'] . '</a>';
    }

    return glyph('map-marker') . $room['Name'];
}
