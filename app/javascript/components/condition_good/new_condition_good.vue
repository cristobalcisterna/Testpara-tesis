  <template>
  <section>
    <div class="modal-card" style="width: 62em; height: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{ modalHeader }}</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body" ref="newConditionGood">


        <div class="box">
          <b-tabs type="is-boxed" position="is-centered">

<!--Bienes a dar de baja-->

            <b-tab-item label="Bien a dar de baja">
              <ValidationObserver v-slot="{ handleSubmit }" ref="observer" >
              <form @submit.prevent="handleSubmit(checkRequest())" >
              <div class="columns is-centered">
                <div class="column is-centered">
                  <div class="center">
                    <h1>Dar de baja un bien</h1>
                  </div>
                  <br />


                  <div class="columns" v-show='!(aux2_good_id == null)'>
                    <div class="column">
                      <b-field label="Nombre:">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux2_namegood" type="text" readonly></b-input>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>



                  <div class="columns">


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Unidad">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_unit_id" :options="units.map((type) => type.id)" :custom-label="
                          (opt) => units.find((x) => x.id === opt).name_unit
                        " placeholder="Seleccionar Unidad" selectLabel="" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id !== null" @input="
        getbuildingbyunit(aux_unit_id);
                          ">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Edificio">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_building_id" :options="buildings.map((type) => type.id)"
                          :custom-label="
                            (opt) => buildings.find((x) => x.id === opt).name_building
                          " placeholder="Seleccionar Unidad" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_unit_id == null || aux_office_id !== null"
                          @input="getofficebybuilding(aux_building_id)">

                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>
                  <div class="columns">
                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Dependencia">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_office_id" :options="offices.map((type) => type.id)" :custom-label="
                          (opt) => offices.find((x) => x.id === opt).name_office
                        " placeholder="Seleccionar dependencia" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id == null || aux_good_id !== null"
                          @input="getgoodbyoffice(aux_office_id)">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Bien">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_good_id" :options="goods.map((type) => type.id)" :custom-label="
                          (opt) =>
                            goods.find((x) => x.id === opt).namegood
                        " placeholder="Seleccionar Bien" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_office_id == null">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>

 
                  <div class="columns"> 
                    <div class="column">
                      <b-field label="Motivo de ingreso">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux_income_reason" placeholder="Ingrese detalles del motivo de ingreso"
                          type="textarea"></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">
                    <div class="column">
                      <b-field label="URL de documento enlace">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux_link" placeholder="Ingrese la URL del documento correspondiente">
                        </b-input>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>


                  <b-field grouped position="is-right">
                    <p class="control">
                      <b-button label="Solicitar dar de baja" type="is-info" @click="checkRequest()" />
                                   </p>
                  </b-field>

                </div>
              </div>
            </form>
 </ValidationObserver>
            </b-tab-item>



<!--Bienes Perdidos-->

            <b-tab-item label="Informar bien Perdido">
              <ValidationObserver v-slot="{ handleSubmit }" ref="observer" >
      <form @submit.prevent="handleSubmit(checkLost())" >
              <div class="columns is-centered">
                <div class="column is-centered">
                  <div class="center">
                    <h1>Informar bien Perdido</h1>
                  </div>
                  <br />


                  <div class="columns" v-show='!(aux2_good_id == null)'>
                    <div class="column">
                      <b-field label="Nombre:">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux2_namegood" type="text" readonly></b-input>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Unidad">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_unit_id" :options="units.map((type) => type.id)" :custom-label="
                          (opt) => units.find((x) => x.id === opt).name_unit
                        " placeholder="Seleccionar Unidad" selectLabel="" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id !== null" @input="
        getbuildingbyunit(aux_unit_id);
                          ">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Edificio"><ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_building_id" :options="buildings.map((type) => type.id)"
                          :custom-label="
                            (opt) => buildings.find((x) => x.id === opt).name_building
                          " placeholder="Seleccionar Unidad" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_unit_id == null || aux_office_id !== null"
                          @input="getofficebybuilding(aux_building_id)">

                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>
                  <div class="columns">
                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Dependencia">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_office_id" :options="offices.map((type) => type.id)" :custom-label="
                          (opt) => offices.find((x) => x.id === opt).name_office
                        " placeholder="Seleccionar dependencia" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id == null || aux_good_id !== null"
                          @input="getgoodbyoffice(aux_office_id)">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Bien">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_good_id" :options="goods.map((type) => type.id)" :custom-label="
                          (opt) =>
                            goods.find((x) => x.id === opt).namegood
                        " placeholder="Seleccionar Bien" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_office_id == null">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>

                  </div>

                  <div class="columns">

                    <div class="column">
                      <b-field label="Fecha de perdida">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-datepicker v-model="aux_lost_date" locale="es-ES" placeholder="Seleccionar fecha de perdida"
                          trap-focus>
                        </b-datepicker>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>

                  
                  <div class="columns">

                    <div class="column">
                      <b-field label="Descripción de perdida">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux_loss_detail" placeholder="Ingrese detalles de la perdida del bien"
                          type="textarea"></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">

                    <div class="column">
                      <b-field label="URL de documento enlace">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux_link" placeholder="Ingrese la URL del documento correspondiente">
                        </b-input>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>


                  <b-field grouped position="is-right">
                    <p class="control">
                      <b-button label="Informar pérdida" type="is-info" @click="checkLost()" />
                    </p>
                  </b-field>

                </div>
              </div>
            </form>
 </ValidationObserver>
            </b-tab-item>




<!--Bienes Destruido-->

            <b-tab-item label="Informar bien Destruido">
              <ValidationObserver v-slot="{ handleSubmit }" ref="observer" >
      <form @submit.prevent="handleSubmit(checkDestruction())" >
              <div class="columns is-centered">
                <div class="column is-centered">

                  <div class="center">
                    <h1>Informar bien Destruido</h1>
                  </div>
                  <br />

                  <div class="columns" v-show='!(aux2_good_id == null)'>
                    <div class="column">
                      <b-field label="Nombre:">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux2_namegood" type="text" readonly></b-input>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>
                  <div class="columns">


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Unidad">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_unit_id" :options="units.map((type) => type.id)" :custom-label="
                          (opt) => units.find((x) => x.id === opt).name_unit
                        " placeholder="Seleccionar Unidad" selectLabel="" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id !== null" @input="
        getbuildingbyunit(aux_unit_id);
                          ">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Edificio">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_building_id" :options="buildings.map((type) => type.id)"
                          :custom-label="
                            (opt) => buildings.find((x) => x.id === opt).name_building
                          " placeholder="Seleccionar Unidad" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_unit_id == null || aux_office_id !== null"
                          @input="getofficebybuilding(aux_building_id)">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>
                  <div class="columns">
                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Dependencia">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_office_id" :options="offices.map((type) => type.id)" :custom-label="
                          (opt) => offices.find((x) => x.id === opt).name_office
                        " placeholder="Seleccionar dependencia" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id == null || aux_good_id !== null"
                          @input="getgoodbyoffice(aux_office_id)">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Bien">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_good_id" :options="goods.map((type) => type.id)" :custom-label="
                          (opt) =>
                            goods.find((x) => x.id === opt).namegood
                        " placeholder="Seleccionar Bien" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_office_id == null">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>

                  </div>
                  <div class="columns">

                    <div class="column">
                      <b-field label="Fecha de destrcción">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-datepicker v-model="aux_destruction_date" locale="es-ES"
                          placeholder="Seleccionar fecha de destrcción" trap-focus>
                        </b-datepicker>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>

                  
                  <div class="columns">

                    <div class="column">
                      <b-field label="Descripción de la destrucción">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux_destruction_detail"
                          placeholder="Ingrese detalles de la destrucción del bien" type="textarea"></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">
                    <div class="column">
                      <b-field label="Reparable">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <multiselect v-model="aux_repairable" :options="reparable" placeholder="¿Es reaparable?"
                          selectLabel="Presione para seleccionar" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true">
                        </multiselect>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">
                    <div class="column">
                      <b-field label="URL de documento enlace">
                        <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                        <b-input v-model="aux_link" placeholder="Ingrese la URL del documento correspondiente">
                        </b-input>
                        <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                      </b-field>
                    </div>
                  </div>



                  <b-field grouped position="is-right" >
                    <p class="control">
                      <b-button label="Informar bien destruido" type="is-info" @click="checkDestruction()" />
                    </p>
                  </b-field>

                </div>
              </div>
            </form>
 </ValidationObserver>
            </b-tab-item>



          </b-tabs>
        </div>
      </section>
    </div>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name: "new_good_condition",
  props: [
    'queryType', 'modalHeader', "id", "goodId"
  ],
  data() {
    return {
      selected: null,
      goods: [],
      offices: [],
      units: [],
      managers: [],
      buildings: [],
      aux_office_id: null,
      aux_unit_id: null,
      aux_building_id: null,
      reparable: ['SI', 'NO'],
      aux_link: null,
      aux_namegood: null,
      aux2_namegood: null,
      aux2_good_id: null,
      aux_lost_date: new Date(),
      aux_loss_detail: null,

      aux_destruction_date: new Date(),
      aux_destruction_detail: null,
      aux_repairable: null,

      aux_request_date: new Date(),
      aux_request_status: null,
      aux_income_reason: null,
      aux_date_entry: new Date(),

      aux_good_id: null,
      aux_condition_id: null,

      aux_activegood: 1,
    };
  },
  methods: {
    async getgood() {
      const response = await axios.get("/goods/" + this.id + ".json");
      this.loading = true;
      this.good = response.data;
      this.aux2_namegood = this.good.namegood;
      this.aux2_good_id = this.good.id;
      console.log(this.aux2_good_id);

    },
    async getgoods() {
      const response = await axios.get("http://localhost:3000/goods.json");
      this.goods = response.data;
    },

    async getunitactive() {
      const response = await axios.get("/units/showactiveunit.json");
      this.units = response.data;
    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
    },

    async getofficebybuilding(item) {
      const response = await axios.get(
        "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
      );
      this.offices = response.data;
    },
    async getgoodbyoffice(item) {
      const response = await axios.get("/goods/showgoodoffice/" + item + ".json");
      this.goods = response.data;
    },

    async checkLost(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      if(this.aux2_good_id == null){
        this.reportLost();
      }
      else{
        this.reportLostaux();
      }
    } 
    },

    async reportLost() {
      const response = await axios.post("/condition_goods.json", {
        lost_date: this.aux_lost_date,
        loss_detail: this.aux_loss_detail,
        link: this.aux_link,
        good_id: this.aux_good_id,
        condition_id: 3,
        activeconditiongood: 1,
      });
      this.$buefy.dialog.alert({
                      title: 'Reporte',
                      type: 'is-success',
                      message: 'El bien ha sido reportado como Perdido',
                      confirmText: 'Aceptar'
                  })
    },

    async reportLostaux() {
      const response = await axios.post("/condition_goods.json", {
        lost_date: this.aux_lost_date,
        loss_detail: this.aux_loss_detail,
        link: this.aux_link,
        good_id: this.aux2_good_id,
        condition_id: 3,
        activeconditiongood: 1,
      });
      this.$buefy.dialog.alert({
                      title: 'Reporte',
                      type: 'is-success',
                      message: 'El bien ha sido reportado como Perdido',
                      confirmText: 'Aceptar'
                  })
    },

    async checkDestruction(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      if(this.aux2_good_id == null){
        this.reportDestruction();
      }
      else{
        this.reportDestructionaux();
      }
    }
      
    },

    async reportDestruction() {
      const response = await axios.post("/condition_goods.json", {
        destruction_date: this.aux_destruction_date,
        destruction_detail: this.aux_destruction_detail,
        repairable: this.aux_repairable,
        link: this.aux_link,
        good_id: this.aux_good_id,
        condition_id: 4,
        activeconditiongood: 1,
      });
      this.$buefy.dialog.alert({
                      title: 'Reporte',
                      type: 'is-success',
                      message: 'El bien ha sido reportado como Destruido',
                      confirmText: 'Aceptar'
                  })
    },

    async reportDestructionaux() {
      const response = await axios.post("/condition_goods.json", {
        destruction_date: this.aux_destruction_date,
        destruction_detail: this.aux_destruction_detail,
        repairable: this.aux_repairable,
        link: this.aux_link,
        good_id: this.aux2_good_id,
        condition_id: 4,
        activeconditiongood: 1,
      });
      this.$buefy.dialog.alert({
                      title: 'Reporte',
                      type: 'is-success',
                      message: 'El bien ha sido reportado como Destruido',
                      confirmText: 'Aceptar'
                  })
    },


    async checkRequest(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      if(this.aux2_good_id == null){
        this.reportRequest();
      }
      else{
        this.reportRequestaux();
      }
    }
    },


    async reportRequest() {
      const response = await axios.post("/condition_goods.json", {

        request_date: this.aux_request_date,
        request_status: this.aux_request_status,
        income_reason: this.aux_income_reason,
        link: this.aux_link,
        good_id: this.aux_good_id,
        condition_id: 1,
        activeconditiongood: 1,

      });
      console.log(this.goods);
      this.$buefy.dialog.alert({
                      title: 'Reporte',
                      type: 'is-success',
                      message: 'El bien ha sido reportado para enviar a bodega de excluidos',
                      confirmText: 'Aceptar'
                  })
    },

    async reportRequestaux() {
      const response = await axios.post("/condition_goods.json", {

        request_date: this.aux_request_date,
        request_status: this.aux_request_status,
        income_reason: this.aux_income_reason,
        link: this.aux_link,
        good_id: this.aux2_good_id,
        condition_id: 1,
        activeconditiongood: 1,

      });
      this.$buefy.dialog.alert({
                      title: 'Reporte',
                      type: 'is-success',
                      message: 'El bien ha sido reportado para enviar a bodega de excluidos',
                      confirmText: 'Aceptar'
                  })
    },










    confirmregister() {
      this.$buefy.dialog.confirm({
        title: "Registrar el Bien",
        message: `¿Esta seguro de registrar esté bien?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",
        onConfirm: () => this.createClick(),
      });
    },
    deleteDropFile(index) {
      this.dropFiles.splice(index, 1)
    },
    
    async check(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmregister();
    }
    },
  },
  created() {
    this.getgood();
    this.getunitactive();

  },
};
</script>