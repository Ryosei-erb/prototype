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
    addCard: function() {
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
