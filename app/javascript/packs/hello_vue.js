import Vue from 'vue/dist/vue.esm'

var card = {
  number: "",
  cvc: "",
  exp_month: "",
  exp_year: "",
}
var app = new Vue({
  el: "#app",
  data: card,
  methods: {
    addCard: function(event) {
      Payjp.createToken(card, (status, response) => {
        if (status == 200) {
          this.number = ""
          this.cvc = ""
          this.exp_month = ""
          this.exp_year = ""
          $("#card_token").append(
                      $('<input type="hidden" name="payjpToken">').val(response.id)
          );
          document.chargeForm.submit();
          alert("登録が完了しました");
        } else {
          alert("カード情報が不正です")
        }
      })
    }
  }
})

// document.addEventListener(
//   "DOMContentLoaded", e => {
//     if (document.getElementById("token_submit") != null) {
//
//       let btn = document.getElementById("token_submit");
//       btn.addEventListener("click", e => {
//         e.preventDefault();
//         let card = {
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         };
//         Payjp.createToken(card, (status, response) => {
//           if (status === 200) {
//             $("#card_number").removeAttr("name");
//             $("#cvc").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name");
//             $("#card_token").append(
//               $('<input type="hidden" name="payjpToken">').val(response.id)
//             );
//             document.chargeForm.submit();
//             alert("登録が完了しました");
//           } else {
//             alert("カード情報が正しくありません。");
//           }
//         });
//       });
//     }
//   },
//   false
// );
