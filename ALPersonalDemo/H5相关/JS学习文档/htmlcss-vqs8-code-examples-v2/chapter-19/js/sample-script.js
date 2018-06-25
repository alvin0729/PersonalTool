/*
 * If visitor chooses the Other radio
 * button, the textarea is enabled
 * and the cursor is placed in it so
 * visitor can start typing. Choosing
 * any remaining radio button
 * disables the textarea.
 *
 * Here's a slightly more detailed explanation:
 * The script applies behavior to radio buttons inside the div with id="choices".
 * If visitor selects any of the radio buttons except the one 
 * with id="other", the textarea with id="other-description" is
 * disabled. If visitor chooses the Other radio button, the textarea
 * is enabled and the cursor is placed in it so visitor can start typing.
 */


/*
 当用户选择 Other 单选按钮时，textarea 会变为可用的，光标也会显示在其中，用户可以马上输入。选择其余
 两个单选按钮中的任意一个，则会禁用 textarea
 */
(function (window, document) {
	'use strict';

	// Locate the id="choices" div and the textarea below the Other radio button
	// and assign them to variables so they can be acted upon

	var choices = document.getElementById('choices'),
		textarea = document.getElementById('other-description');

	// Do nothing if the radio buttons and textarea don't exist in the HTML
	if (!choices || !textarea) {
		return;
	}

	// Disable textarea by default
	textarea.disabled = true;

	// Add behavior to radio buttons
	choices.onclick = function(e) {
		var target,
			e;

		// Check for IE7 or prior
		if (!e) {
			e = window.event;
		}

		// Event target for modern browsers and IE7 or prior
		target = e.target || e.srcElement;

		// Toggle textarea based on radio button chosen
		if (target.getAttribute('type') === 'radio') {
			if (target.id !== 'other') {
				textarea.disabled = true;	// Disable the textarea
			} else { // Visitor selected Other
				textarea.disabled = false; 	// Enable the textarea
				textarea.focus(); 			// Place cursor in the textarea
			}
		}
	};
}(window, document));