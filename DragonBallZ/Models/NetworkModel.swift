import Foundation

final class NetworkModel{
    
    //armamos los errores posibles a aparecer
    enum NetworkError:Error {
        case unknown
        case malformedUrl
        case decodingFailed
        case encodingFailed
        case noData
        case statusCode(code:Int?)
        case noToken
    }
    
    //"/api/auth/login/"
    //login (debe ser correcto el nombre y la password, devuelve token)
    static func login (email: String, password: String, completion: @escaping (String,NetworkError?)-> Void ){
        
        //1)armamos los componentes de la url y mediante ella creamos la url que se le va a pasar al request
        var URLComponents=URLComponents()
        URLComponents.scheme = "https"
        URLComponents.host = "dragonball.keepcoding.education"
        URLComponents.path = "/api/auth/login"
        guard let url = URLComponents.url else {
            completion("",NetworkError.malformedUrl)
            return
        }
        
        //2)armamos la request pasandole la url que creamos
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let loginstring = String(format: "%@:%@",email,password)
        guard let logindata = loginstring.data(using: .utf8) else {
            completion("",NetworkError.encodingFailed)
            return
        }
        let base64loginstring = logindata.base64EncodedString()
        request.setValue("Basic \(base64loginstring)", forHTTPHeaderField: "Authorization")
        
        //3)comenzamos el llamado a la request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //verificamos que no hay habido ningún error en la llamada
            guard error==nil else {
                completion("",NetworkError.unknown)
                return
            }
            
            //nos aseguramos que la llamada haya sido exitosa
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion("",NetworkError.statusCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            //verificamos que haya data
            guard let data else {
                completion("",NetworkError.noData)
                return
            }
            
            //nos aseguramenos que el dato que vino se decodifique correctamente y lo guardamos en una variable token
            guard let token = String(data: data, encoding: .utf8) else {
                completion("",NetworkError.decodingFailed)
                return
            }
            
            completion(token,nil)
        }
        task.resume()
    }

    //"/api/heros/all"
    //devolvemos la lista de heroes
    static func getHeroesList (token: String, completion: @escaping ([Hero],NetworkError?) -> Void ){
        
        //1)armamos los componentes de la url y mediante ella creamos la url que se le va a pasar al request
        var URLComponents = URLComponents()
        URLComponents.scheme = "https"
        URLComponents.host = "dragonball.keepcoding.education"
        URLComponents.path = "/api/heros/all"
        guard let url = URLComponents.url else {
            completion([],NetworkError.malformedUrl)
            return
        }
        URLComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        
        
        //2)armamos la request pasandole la url que creamos
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = URLComponents.query?.data(using: .utf8)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        //3)comenzamos el llamado a la request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //verificamos que no hay habido ningún error en la llamada
            guard error==nil else {
                completion([],NetworkError.unknown)
                return
            }
            
            //nos aseguramos que la llamada haya sido exitosa
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion([],NetworkError.statusCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            //verificamos que haya data
            guard let data else {
                completion([],NetworkError.noData)
                return
            }
            
            //se intenta decodificar "[Hero]"
            guard let heroes = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([],NetworkError.decodingFailed)
                return
            }
            
            completion(heroes,nil)
        }
        task.resume()
    }
}
