#
# Copyright (C) 2016 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

class Speedgrader
  class << self
    include SeleniumDependencies

    # components/elements
    def right_inner_panel
      f('#rightside_inner')
    end

    def grade_value
      f('#grade_container input[type=text]').attribute('value')
    end

    def fraction_graded
      f("#x_of_x_graded")
    end

    def average_grade
      f("#average_score")
    end

    def grade_input
      f('#grading-box-extended')
    end

    def grading_enabled?
      grade_input.enabled?
    end

    def top_bar
      f("#content")
    end

    def closed_gp_notice_selector
      "#closed_gp_notice"
    end

    def settings_link
      f('#speedgrader-settings button')
    end

    def options_link
      fxpath('//span[text() = "Options"]')
    end

    def keyboard_shortcuts_link
      fxpath('//ul[@role = "menu"]//span[text() = "Keyboard Shortcuts"]')
    end

    def mute_button
      f('button#mute_link')
    end

    def hide_students_chkbox
      f('#hide_student_names')
    end

    def selected_student
      f('span.ui-selectmenu-item-header')
    end

    def student_x_of_x_label
      f('#x_of_x_students_frd')
    end

    def student_dropdown_menu
      f('div.ui-selectmenu-menu.ui-selectmenu-open')
    end

    def next_student_btn
      f('#next-student-button')
    end

    def next_student
      f('.next')
    end

    def previous_student
      f('.prev')
    end

    def students_dropdown_button
      f('#students_selectmenu-button')
    end

    def comment_citation
      ff('.author_name')
    end

    def new_comment_text_area
      f('#speedgrader_comment_textarea')
    end

    def comment_submit_button
      f('#comment_submit_button')
    end

    def delete_comment
      ff('.delete_comment_link')
    end

    def comments
      ff('#comments>.comment')
    end

    def submission_file_name
      f('#submission_files_list .submission-file .display_name')
    end

    def submission_to_view_dropdown
      f('#submission_to_view')
    end

    def submission_file_download
      f('.submission-file-download')
    end

    def attachment_button
      f('#add_attachment')
    end

    def attachment_input
      f('#comment_attachments input')
    end

    def attachment_link
      f('.display_name')
    end

    def submission_status_pill(status)
      fj("[title='#{status}']:contains('#{status}')")
    end

    def late_points_deducted_text
      f("#points-deducted").text
    end

    def final_late_policy_grade_text
      f("#final-grade").text
    end

    def view_rubric_button
      fj("button:contains('View Rubric')")
    end

    def rubric_grade_input(criteria_id)
      f("#criterion_#{criteria_id} input.criterion_points")
    end

    def save_rubric_button
      f("button.save_rubric_button")
    end

    def student_grading_status_icon(student_name)
      fj("#students_selectmenu-button:contains('#{student_name}')")
    end

    def sections_menu_link
      f("#section-menu-link")
    end

    def section_with_id(section_id)
      f("a.section_#{section_id}")
    end

    def students_select_menu_list
      ff("#students_selectmenu-menu li .ui-selectmenu-item-header")
    end

    def section_all
      f("a[data-section-id=\"all\"]")
    end

    def grading_details_container
      f("div#grading_details_container")
    end

    def show_details_button
      f("button", grading_details_container)
    end

    def provisional_grade_radio_buttons
      ff("label", grading_details_container)
    end

    def provisional_grade_radio_button_by_label(label)
      fj(":contains('#{label}')", provisional_grade_radio_buttons)
    end

    # returns a list of comment strings from right pane
    def comment_list
      ff('span.comment').map(&:text)
    end

    def media_comment_button
      f('#media_comment_button')
    end

    def media_audio_record_option
      f('#audio_record_option')
    end

    def media_video_record_option
      f('#video_record_option')
    end

    def attachment_input_close_button
      f('#comment_attachments a')
    end

    def comment_posted_at
      ff('#comments > .comment .posted_at')
    end

    def avatar
      f("#avatar_image")
    end

    def avatar_comment
      f("#comments > .comment .avatar")
    end

    def assignment_link
      f('#assignment_url')
    end

    def comment_saved_alert
      f('#comment_saved')
    end

    def comment_saved_alert_close_button
      f('#comment_saved .dismiss_alert')
    end

    def draft_comments
      ff('#comments .comment.draft')
    end

    def draft_comment_markers
      ff('#comments .comment.draft .comment_flex > .draft-marker')
    end

    def publish_draft_link
      f('#comments .comment.draft .comment_flex > button.submit_comment_button')
    end

    def draft_comment_delete_button
      ff('#comments .comment.draft .comment_flex > a.delete_comment_link')
    end

    def comment_delete_buttons
      ff('#comments .comment .comment_flex > a.delete_comment_link')
    end

    # action
    def visit(course_id, assignment_id)
      get "/courses/#{course_id}/gradebook/speed_grader?assignment_id=#{assignment_id}"
      visibility_check = grade_input
      keep_trying_until { visibility_check.displayed? }
    end

    def select_provisional_grade_by_label(label)
      provisional_grade_radio_button_by_label(label).click
      driver.action.send_keys(:space).perform
    end

    def visit_section(section)
      students_dropdown_button.click
      hover(sections_menu_link)
      section.click
      wait_for_dom_ready
    end

    def enter_grade(grade)
      grade_input.send_keys(grade, :enter)
    end

    def current_grade
      grade_input['value']
    end

    def click_students_dropdown
      students_dropdown_button.click
    end

    def click_next_or_prev_student(direction_string)
      if direction_string.equal?(:next)
        next_student.click
      else
        previous_student.click
      end
    end

    def click_settings_link
      settings_link.click
    end

    def click_options_link
      options_link.click
    end

    def click_keyboard_shortcuts_link
      keyboard_shortcuts_link.click
    end

    def select_hide_student_names
      hide_students_chkbox.click
    end

    def click_next_student_btn
      next_student_btn.click
    end

    def add_comment_and_submit(comment)
      replace_content(new_comment_text_area, comment)
      comment_submit_button.click
    end

    def add_comment_attachment(file_path)
      attachment_button.click
      attachment_input.send_keys(file_path)
    end

    def click_submissions_to_view
      submission_to_view_dropdown.click
    end

    def select_option_submission_to_view(option_index)
      click_option(submission_to_view_dropdown, option_index, :value)
    end

    def submit_settings_form
      wait_for_new_page_load { fj('.ui-dialog-buttonset .ui-button:visible:last').click }
    end

    def grade_rubric_criteria(criteria_id, grade)
      rubric_grade_input(criteria_id).send_keys(grade)
    end

    def clear_new_comment
      new_comment_text_area.clear
    end

    def check_hide_student_name
      click_settings_link
      click_options_link
      unless hide_students_chkbox.selected?
        select_hide_student_names
      end
      submit_settings_form
    end

    def uncheck_hide_student_name
      click_settings_link
      click_options_link
      if hide_students_chkbox.selected?
        select_hide_student_names
      end
      submit_settings_form
    end

    def select_student(student)
      click_students_dropdown
      students_select_menu_list.find { |e| e.text == student.name}.click
      wait_for_ajaximations
    end

    def fetch_comment_posted_at_by_index(index)
      comment_posted_at[index]
    end

    def close_saved_comment_alert
      comment_saved_alert_close_button.click
    end
  end
end
