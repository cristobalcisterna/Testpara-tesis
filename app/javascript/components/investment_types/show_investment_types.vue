  <template>
  <section class="b-tooltips">
    <div 
      class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px"
    >
     <h1>Detalle del Tipo de inversión</h1>
      <b-tabs type="is-boxed" position="is-centered">
           <div class="center"> <h1>Información del Tipo de inversión</h1></div>
          <div class="box" >
 
          <div v-if="investment_type" class="columns is-centered">
            <div class="column is-centered">

              <div class="columns"> 
                <div class="column">
                  <b-field label="Nombre Tipo de inversión:">
                       <b-input
                    v-model=" investment_type.name_investment_type " type="text" readonly></b-input>
                  </b-field>
                </div>
              </div>

              <div class="columns">
                <div class="column">
                  <b-field label="Descripción:">
                       <b-input
                    v-model="investment_type.detail" type="text" readonly></b-input>
                  </b-field>
                </div>
              </div>

            </div>
          </div>

          <div v-else>
            <p>Loading</p>
          </div>
          </div>
      </b-tabs>
    </div>
    <a href="/investment_types"   style= "font-weight: normal;
  font-size: 20px;
  font-family: Arial;
  margin: 10px;
  margin-left: 30px;">Volver</a>
  </section>
</template>


<script>
import axios from "axios";
export default {
  name:"show_investment_types",
  props: ["id",'queryType', 'modalHeader','investment_typeId'],
  data() {
    return {
      investment_type: null,
      props: ["id"],
    };
  },
  methods: {
    async getinvestments() {
      const response = await axios.get("/investment_types/" + this.investment_typeId + ".json");
      this.investment_type = response.data;
    },

  },
  created() {
    this.getinvestments();
  },
};
</script>

