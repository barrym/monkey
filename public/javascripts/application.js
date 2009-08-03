// Place your application-specific JavaScript functions and classes here
// This file is wlly included by javascript_include_tag :defaults

Event.observe(window, 'load', function() {
  Event.observe('post_body', 'focus', function() {
    showNewPostForm();
  });
});

function showNewPostForm() {
  if(!$('new_post_subject').visible()) {
    Effect.BlindDown('new_post_subject', { duration: 0.3 });
    Effect.BlindDown('new_post_submit', { duration: 0.3 });
  }
}

function hideNewPostForm() {
  if($('new_post_subject').visible()) {
    Effect.BlindUp('new_post_subject', { duration: 0.3 });
    Effect.BlindUp('new_post_submit', { duration: 0.3 });
  }
}
