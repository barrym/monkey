// Place your application-specific JavaScript functions and classes here
// This file is wlly included by javascript_include_tag :defaults

Event.observe(window, 'load', function() {
  Event.observe('post_subject', 'focus', function() {
    showNewPostForm();
  });
});

function showNewPostForm() {
  if(!$('new_post_body').visible()) {
    Effect.BlindDown('new_post_body', { duration: 0.3 });
    Effect.BlindDown('new_post_submit', { duration: 0.3 });
    $('post_subject').clear();
  }
}

function hideNewPostForm() {
  if($('new_post_body').visible()) {
    Effect.BlindUp('new_post_body', { duration: 0.3 });
    Effect.BlindUp('new_post_submit', { duration: 0.3 });
  }
}

function clearNewPostForm() {
  if($('new_post_body').visible()) {
    $('post_body').clear();
    $('post_subject').value = "Click here to post";
    hideNewPostForm();
  }
}
