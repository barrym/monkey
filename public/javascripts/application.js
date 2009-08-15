// Place your application-specific JavaScript functions and classes here
// This file is wlly included by javascript_include_tag :defaults

Event.observe(document, 'dom:loaded', function() {
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

function showCommentForm(dom_id, body) {
  body = (body || "");
  $(dom_id + '_comment_body').value = body;
  $(dom_id + '_comment').show();
  $(dom_id + '_comment_body').focus();
}

function hideCommentForm(dom_id) {
  $(dom_id + '_comment').hide();
}

function displayNewComment(entity_dom_id, comment_dom_id, content) {
  if($(entity_dom_id)) {
    Element.insert(entity_dom_id, {bottom: content});
    // Effect.SlideDown(comment_dom_id, {duration: 0.5});
    $(comment_dom_id).highlight();
  }
}
